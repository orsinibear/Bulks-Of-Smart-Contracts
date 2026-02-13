


desc  -  

Users can avoid deficit reporting during liquidation by maintaining minimal collateral in another reserve. When main collateral is liquidated, any non-zero secondary collateral prevents deficit flagging, even if trivial amounts. This enables strategic avoidance of deficit status, delays debt recognition, and allows uncollectible debt to accrue interest. Short-term fix: treat small collateral as inactive. Long-term: redesign deficit reporting to prevent exploitation.


address-   
0x8147b99DF7672A21809c9093E6F6CE1a60F119Bd