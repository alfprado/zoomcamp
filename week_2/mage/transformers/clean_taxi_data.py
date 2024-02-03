import re

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

def change_case(str):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', str)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    
    print("Rows with zero passengers: ", data['passenger_count'].isin([0]).sum())
    print("Rows with zero trip distance: ", data['trip_distance'].isin([0]).sum())

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    data.columns = [change_case(column) for column in data.columns]

    return data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]


@test
def test_vendor_id(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, 'Test vendor_id in columns'

@test
def test_passenger_count(output, *args) -> None:

    assert output['passenger_count'].isin([0]).sum() == 0, 'Test passenger_count greater than 0'

@test
def test_trip_distance(output, *args) -> None:

    assert output['trip_distance'].isin([0]).sum() == 0, 'Test trip_distance greater than 0'
