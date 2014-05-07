From: =?UTF-8?B?0JjQstCw0L0g0KHQvtC70Y/QvdC60LjQvQ==?= <vanzef@gmail.com>
Subject: crash of f2fs partition
Date: Wed, 7 May 2014 21:54:37 +0400
Message-ID: <CAHn27kbqKEZ5roxhygGNYTz7LddNV0562qDu=JFWw=39OKU+6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7825898419556633805=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vanzef@gmail.com>) id 1Wi63I-0005mW-L0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 May 2014 17:54:44 +0000
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wi63H-0002c3-Gj
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 May 2014 17:54:44 +0000
Received: by mail-qc0-f169.google.com with SMTP id e16so1523303qcx.28
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 07 May 2014 10:54:38 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

--===============7825898419556633805==
Content-Type: multipart/alternative; boundary=047d7bdc88e4dc51d904f8d30eb3

--047d7bdc88e4dc51d904f8d30eb3
Content-Type: text/plain; charset=UTF-8

Hello, everybody!

I use F2FS as my /home fs (it is on usb flash drive). One day I was using
Skype and it freezed my laptop, so i needed to reboot. After reboot I had
next error message: "Failed to mount /home". I use Archlinux. It is not
kernel problem, because live cd also couldn't mount it.

Here is my fsck.f2fs output:
Info: sector size = 512
Info: total sectors = 18857984 (in 512bytes)
[print_node_info:  77] Node ID [0x137d3:79827] is inode
i_mode                                [0x    81a4 : 33188]
i_uid                                 [0x     3e8 : 1000]
i_gid                                 [0x      64 : 100]
i_links                               [0x       1 : 1]
i_size                                [0x   300b0 : 196784]
i_blocks                              [0x      aa : 170]
i_atime                               [0x535d4015 : 1398620181]
i_atime_nsec                          [0x28c0e49b : 683730075]
i_ctime                               [0x535d4016 : 1398620182]
i_ctime_nsec                          [0x22cb0394 : 583730068]
i_mtime                               [0x535d4016 : 1398620182]
i_mtime_nsec                          [0x22cb0394 : 583730068]
i_generation                          [0x4f99325f : 1335439967]
i_current_depth                       [0x       1 : 1]
i_xattr_nid                           [0x       0 : 0]
i_flags                               [0x       0 : 0]
i_pino                                [0x     856 : 2134]
i_namelen                             [0x      11 : 17]
i_name                                [places.sqlite-wal]
i_ext: fofs:18 blkaddr:1984b4 len:0
i_addr[0]                             [0x  1ca848 : 1878088]
i_addr[1]                             [0x  1ca499 : 1877145]
i_addr[2]                             [0x  1ca49a : 1877146]
i_addr[3]                             [0x  1ca49b : 1877147]
i_addr[0x4] points data block   [0x1ca49c]
i_nid[0]                              [0x       0 : 0]
i_nid[1]                              [0x       0 : 0]
i_nid[2]                              [0x       0 : 0]
i_nid[3]                              [0x       0 : 0]
i_nid[4]                              [0x       0 : 0]


Assertion failed!
[fsck_chk_inode_blk: 394] i_blocks == *blk_cnt

Here is a error message after mount:
http://imgur.com/alkvI3J

Is there any way to repair fs and if not - how can I take some files from
it?
Thanks.

--047d7bdc88e4dc51d904f8d30eb3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PkhlbGxvLCBldmVyeWJvZHkh
PGJyPjxicj48L2Rpdj5JIHVzZSBGMkZTIGFzIG15IC9ob21lIGZzIChpdCBpcyBvbiB1c2IgZmxh
c2ggZHJpdmUpLiBPbmUgZGF5IEkgd2FzIHVzaW5nIFNreXBlIGFuZCBpdCBmcmVlemVkIG15IGxh
cHRvcCwgc28gaSBuZWVkZWQgdG8gcmVib290LiBBZnRlciByZWJvb3QgSSBoYWQgbmV4dCBlcnJv
ciBtZXNzYWdlOiAmcXVvdDtGYWlsZWQgdG8gbW91bnQgL2hvbWUmcXVvdDsuIEkgdXNlIEFyY2hs
aW51eC4gSXQgaXMgbm90IGtlcm5lbCBwcm9ibGVtLCBiZWNhdXNlIGxpdmUgY2QgYWxzbyBjb3Vs
ZG4mIzM5O3QgbW91bnQgaXQuPGJyPg0KDQo8YnI+PC9kaXY+SGVyZSBpcyBteSBmc2NrLmYyZnMg
b3V0cHV0OiA8YnI+SW5mbzogc2VjdG9yIHNpemUgPSA1MTI8YnI+SW5mbzogdG90YWwgc2VjdG9y
cyA9IDE4ODU3OTg0IChpbiA1MTJieXRlcyk8YnI+W3ByaW50X25vZGVfaW5mbzrCoCA3N10gTm9k
ZSBJRCBbMHgxMzdkMzo3OTgyN10gaXMgaW5vZGU8YnI+aV9tb2RlwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoCA4MWE0
IDogMzMxODhdPGJyPg0KDQppX3VpZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoMKgIDNlOCA6IDEwMDBdPGJyPmlf
Z2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgWzB4wqDCoMKgwqDCoCA2NCA6IDEwMF08YnI+aV9saW5rc8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDC
oMKgIDEgOiAxXTxicj5pX3NpemXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoCAzMDBiMCA6IDE5Njc4NF08YnI+DQoNCmlf
YmxvY2tzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgWzB4wqDCoMKgwqDCoCBhYSA6IDE3MF08YnI+aV9hdGltZcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4NTM1ZDQwMTUgOiAx
Mzk4NjIwMTgxXTxicj5pX2F0aW1lX25zZWPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgWzB4MjhjMGU0OWIgOiA2ODM3MzAwNzVdPGJyPmlfY3RpbWXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsw
eDUzNWQ0MDE2IDogMTM5ODYyMDE4Ml08YnI+DQoNCmlfY3RpbWVfbnNlY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHgyMmNiMDM5NCA6IDU4MzczMDA2
OF08YnI+aV9tdGltZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgWzB4NTM1ZDQwMTYgOiAxMzk4NjIwMTgyXTxicj5pX210aW1lX25zZWPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4MjJjYjAz
OTQgOiA1ODM3MzAwNjhdPGJyPmlfZ2VuZXJhdGlvbsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHg0Zjk5MzI1ZiA6IDEzMzU0Mzk5NjddPGJyPg0KDQpp
X2N1cnJlbnRfZGVwdGjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
WzB4wqDCoMKgwqDCoMKgIDEgOiAxXTxicj5pX3hhdHRyX25pZMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoMKgwqDCoCAwIDogMF08YnI+
aV9mbGFnc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDAgOiAwXTxicj5pX3Bpbm/CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqAg
ODU2IDogMjEzNF08YnI+DQoNCmlfbmFtZWxlbsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoMKgIDExIDogMTddPGJyPmlfbmFt
ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKg
wqDCoCBbcGxhY2VzLnNxbGl0ZS13YWxdPGJyPmlfZXh0OiBmb2ZzOjE4IGJsa2FkZHI6MTk4NGI0
IGxlbjowPGJyPmlfYWRkclswXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBbMHjCoCAxY2E4NDggOiAxODc4MDg4XTxicj4NCg0KaV9hZGRyWzFd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsw
eMKgIDFjYTQ5OSA6IDE4NzcxNDVdPGJyPmlfYWRkclsyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoCAxY2E0OWEgOiAxODc3MTQ2XTxi
cj5pX2FkZHJbM13CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgWzB4wqAgMWNhNDliIDogMTg3NzE0N108YnI+aV9hZGRyWzB4NF0gcG9pbnRzIGRh
dGEgYmxvY2vCoMKgIFsweDFjYTQ5Y108YnI+DQoNCmlfbmlkWzBdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDAg
OiAwXTxicj5pX25pZFsxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoMKgwqDCoCAwIDogMF08YnI+aV9uaWRbMl3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKg
wqDCoMKgwqAgMCA6IDBdPGJyPmlfbmlkWzNdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDAgOiAwXTxicj4NCg0K
aV9uaWRbNF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKg
IMKgwqDCoCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBdPGJyPjxicj48YnI+QXNzZXJ0aW9uIGZhaWxl
ZCE8YnI+W2ZzY2tfY2hrX2lub2RlX2JsazogMzk0XSBpX2Jsb2NrcyA9PSAqYmxrX2NudDxicj48
YnI+PC9kaXY+SGVyZSBpcyBhIGVycm9yIG1lc3NhZ2UgYWZ0ZXIgbW91bnQ6PGJyPjxhIGhyZWY9
Imh0dHA6Ly9pbWd1ci5jb20vYWxrdkkzSiI+aHR0cDovL2ltZ3VyLmNvbS9hbGt2STNKPC9hPjxi
cj4NCjxicj48L2Rpdj5JcyB0aGVyZSBhbnkgd2F5IHRvIHJlcGFpciBmcyBhbmQgaWYgbm90IC0g
aG93IGNhbiBJIHRha2Ugc29tZSBmaWxlcyBmcm9tIGl0Pzxicj48L2Rpdj5UaGFua3MuPGJyPjxk
aXY+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2Pjxicj48YnI+DQo8L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--047d7bdc88e4dc51d904f8d30eb3--


--===============7825898419556633805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--===============7825898419556633805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============7825898419556633805==--
