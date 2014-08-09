From: Matt Parnell <mparnell@gmail.com>
Subject: Power Outage Corruption - Recovery?
Date: Sat, 9 Aug 2014 22:15:15 +0000
Message-ID: <CABeR261Ep6fw+--kdtUCTEK0zktnRYQ=y6ScCKa8YEMXMxadOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7453914075522493236=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mparnell@gmail.com>) id 1XGEv4-0005wO-Gu
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 22:15:22 +0000
Received: from mail-qc0-f171.google.com ([209.85.216.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XGEv3-0001dV-32
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 22:15:22 +0000
Received: by mail-qc0-f171.google.com with SMTP id r5so483791qcx.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 09 Aug 2014 15:15:15 -0700 (PDT)
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

--===============7453914075522493236==
Content-Type: multipart/alternative; boundary=001a11c308ec068c1e050039a83c

--001a11c308ec068c1e050039a83c
Content-Type: text/plain; charset=UTF-8

I had a similar issue as a gentlemen whose message I recently read on this
list, where power loss caused his f2fs partition to cause a kernel oops
every time it was attempted to mount. I have the same issue. Is any form of
recovery possible?

Photorec was able to get most of it but there are two hard drive keys and a
keepass database that I wish to try and recover.

Setting fsck.f2fs debug level to 9, I can get output like the below and
even view the inode information with dump.f2fs.

Is there a way I can, through a program or through hex editing, get these
files back, or even repair the whole partition?

Thanks!

fsck output:

[fsck_chk_dentry_blk: 567] [  2] - no[0x8d] name[keys] len[0x4] ino[0x3a1]
type[0x2]
[fsck_chk_xattr_blk: 709] ino[0x3a1] x_nid[0x3a8]
[fsck_chk_dentry_blk: 567] [  3] - no[0x2] name[storage.key] len[0xb]
ino[0x3a2] type[0x1]
[fsck_chk_xattr_blk: 709] ino[0x3a2] x_nid[0x3a3]
[fsck_chk_dentry_blk: 567] [  3] - no[0x4] name[tmp.key] len[0x7]
ino[0x3a4] type[0x1]
[fsck_chk_xattr_blk: 709] ino[0x3a4] x_nid[0x3a5]
[fsck_chk_dentry_blk: 567] [  3] - no[0x5] name[home.key] len[0x8]
ino[0x3a6] type[0x1]
[fsck_chk_xattr_blk: 709] ino[0x3a6] x_nid[0x3a7]
[fsck_chk_dentry_blk: 588] [  3] Dentry Block [0xac3912] Done : dentries:3
in 214 slots (len:255)

[fsck_chk_inode_blk: 379] Directory Inode: ino: 3a1 name: keys depth: 1
child files: 3

inode dump:

Info: sector size = 512
Info: total sectors = 92270592 (in 512bytes)
[print_node_info:  77] Node ID [0x3a2:930] is inode
i_mode                                [0x    81a4 : 33188]
i_uid                                 [0x       0 : 0]
i_gid                                 [0x       0 : 0]
i_links                               [0x       1 : 1]
i_size                                [0x    1000 : 4096]
i_blocks                              [0x       3 : 3]
i_atime                               [0x53b92ed2 : 1404645074]
i_atime_nsec                          [0x234fa2de : 592421598]
i_ctime                               [0x53ba3331 : 1404711729]
i_ctime_nsec                          [0x3a88bfa8 : 982040488]
i_mtime                               [0x53b90ec9 : 1404636873]
i_mtime_nsec                          [0x374e1dc2 : 927866306]
i_generation                          [0xf382a0df : 4085424351]
i_current_depth                       [0x       1 : 1]
i_xattr_nid                           [0x     3a3 : 931]
i_flags                               [0x       0 : 0]
i_pino                                [0x     3a1 : 929]
i_namelen                             [0x       b : 11]
i_name                                [storage.key]
i_ext: fofs:0 blkaddr:693511 len:1
i_addr[0]                             [0x  693511 : 6894865]
i_addr[1]                             [0x       0 : 0]
i_addr[2]                             [0x       0 : 0]
i_addr[3]                             [0x       0 : 0]
i_nid[0]                              [0x       0 : 0]
i_nid[1]                              [0x       0 : 0]
i_nid[2]                              [0x       0 : 0]
i_nid[3]                              [0x       0 : 0]
i_nid[4]                              [0x       0 : 0]


Done.

--001a11c308ec068c1e050039a83c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SSBoYWQgYSBzaW1pbGFyIGlzc3VlIGFzIGEg
Z2VudGxlbWVuIHdob3NlIG1lc3NhZ2UgSSByZWNlbnRseSByZWFkIG9uIHRoaXMgbGlzdCwgd2hl
cmUgcG93ZXIgbG9zcyBjYXVzZWQgaGlzIGYyZnMgcGFydGl0aW9uIHRvIGNhdXNlIGEga2VybmVs
IG9vcHMgZXZlcnkgdGltZSBpdCB3YXMgYXR0ZW1wdGVkIHRvIG1vdW50LiBJIGhhdmUgdGhlIHNh
bWUgaXNzdWUuIElzIGFueSBmb3JtIG9mIHJlY292ZXJ5IHBvc3NpYmxlPzxicj4NCjwvZGl2Pjxk
aXY+PGJyPlBob3RvcmVjIHdhcyBhYmxlIHRvIGdldCBtb3N0IG9mIGl0IGJ1dCB0aGVyZSBhcmUg
dHdvIGhhcmQgZHJpdmUga2V5cyBhbmQgYSBrZWVwYXNzIGRhdGFiYXNlIHRoYXQgSSB3aXNoIHRv
IHRyeSBhbmQgcmVjb3Zlci4gPGJyPjxicj5TZXR0aW5nIGZzY2suZjJmcyBkZWJ1ZyBsZXZlbCB0
byA5LCBJIGNhbiBnZXQgb3V0cHV0IGxpa2UgdGhlIGJlbG93IGFuZCBldmVuIHZpZXcgdGhlIGlu
b2RlIGluZm9ybWF0aW9uIHdpdGggZHVtcC5mMmZzLjxicj4NCjwvZGl2Pg0KPGJyPklzIHRoZXJl
IGEgd2F5IEkgY2FuLCB0aHJvdWdoIGEgcHJvZ3JhbSBvciB0aHJvdWdoIGhleCBlZGl0aW5nLCBn
ZXQgdGhlc2UgZmlsZXMgYmFjaywgb3IgZXZlbiByZXBhaXIgdGhlIHdob2xlIHBhcnRpdGlvbj8g
PGJyPjxicj48L2Rpdj5UaGFua3MhPGJyPjxicj5mc2NrIG91dHB1dDo8YnI+PGJyPltmc2NrX2No
a19kZW50cnlfYmxrOiA1NjddIFvCoCAyXSAtIG5vWzB4OGRdIG5hbWVba2V5c10gbGVuWzB4NF0g
aW5vWzB4M2ExXSB0eXBlWzB4Ml08YnI+DQoNCltmc2NrX2Noa194YXR0cl9ibGs6IDcwOV0gaW5v
WzB4M2ExXSB4X25pZFsweDNhOF08YnI+W2ZzY2tfY2hrX2RlbnRyeV9ibGs6IDU2N10gW8KgIDNd
IC0gbm9bMHgyXSBuYW1lW3N0b3JhZ2Uua2V5XSBsZW5bMHhiXSBpbm9bMHgzYTJdIHR5cGVbMHgx
XTxicj5bZnNja19jaGtfeGF0dHJfYmxrOiA3MDldIGlub1sweDNhMl0geF9uaWRbMHgzYTNdPGJy
Pltmc2NrX2Noa19kZW50cnlfYmxrOiA1NjddIFvCoCAzXSAtIG5vWzB4NF0gbmFtZVt0bXAua2V5
XSBsZW5bMHg3XSBpbm9bMHgzYTRdIHR5cGVbMHgxXTxicj4NCg0KW2ZzY2tfY2hrX3hhdHRyX2Js
azogNzA5XSBpbm9bMHgzYTRdIHhfbmlkWzB4M2E1XTxicj5bZnNja19jaGtfZGVudHJ5X2Jsazog
NTY3XSBbwqAgM10gLSBub1sweDVdIG5hbWVbaG9tZS5rZXldIGxlblsweDhdIGlub1sweDNhNl0g
dHlwZVsweDFdPGJyPltmc2NrX2Noa194YXR0cl9ibGs6IDcwOV0gaW5vWzB4M2E2XSB4X25pZFsw
eDNhN108YnI+W2ZzY2tfY2hrX2RlbnRyeV9ibGs6IDU4OF0gW8KgIDNdIERlbnRyeSBCbG9jayBb
MHhhYzM5MTJdIERvbmUgOiBkZW50cmllczozIGluIDIxNCBzbG90cyAobGVuOjI1NSk8YnI+DQoN
Cjxicj5bZnNja19jaGtfaW5vZGVfYmxrOiAzNzldIERpcmVjdG9yeSBJbm9kZTogaW5vOiAzYTEg
bmFtZToga2V5cyBkZXB0aDogMSBjaGlsZCBmaWxlczogMzxicj48YnI+PC9kaXY+aW5vZGUgZHVt
cDo8YnI+PGJyPkluZm86IHNlY3RvciBzaXplID0gNTEyPGJyPkluZm86IHRvdGFsIHNlY3RvcnMg
PSA5MjI3MDU5MiAoaW4gNTEyYnl0ZXMpPGJyPltwcmludF9ub2RlX2luZm86wqAgNzddIE5vZGUg
SUQgWzB4M2EyOjkzMF0gaXMgaW5vZGU8YnI+DQppX21vZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgIDgxYTQgOiAz
MzE4OF08YnI+aV91aWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBdPGJyPmlfZ2lkwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
WzB4wqDCoMKgwqDCoMKgIDAgOiAwXTxicj5pX2xpbmtzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoMKgwqAgMSA6IDFd
PGJyPg0KaV9zaXplwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoCAxMDAwIDogNDA5Nl08YnI+aV9ibG9ja3PCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKg
wqDCoMKgwqAgMyA6IDNdPGJyPmlfYXRpbWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweDUzYjkyZWQyIDogMTQwNDY0NTA3NF08YnI+
aV9hdGltZV9uc2VjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDC
oMKgIFsweDIzNGZhMmRlIDogNTkyNDIxNTk4XTxicj4NCmlfY3RpbWXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweDUzYmEzMzMxIDog
MTQwNDcxMTcyOV08YnI+aV9jdGltZV9uc2VjwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCDCoMKgwqAgwqDCoMKgIFsweDNhODhiZmE4IDogOTgyMDQwNDg4XTxicj5pX210aW1lwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBb
MHg1M2I5MGVjOSA6IDE0MDQ2MzY4NzNdPGJyPmlfbXRpbWVfbnNlY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHgzNzRlMWRjMiA6IDkyNzg2NjMwNl08
YnI+DQppX2dlbmVyYXRpb27CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgWzB4ZjM4MmEwZGYgOiA0MDg1NDI0MzUxXTxicj5pX2N1cnJlbnRfZGVwdGjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDEg
OiAxXTxicj5pX3hhdHRyX25pZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDC
oMKgwqAgwqDCoMKgIFsweMKgwqDCoMKgIDNhMyA6IDkzMV08YnI+aV9mbGFnc8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKg
wqDCoMKgIDAgOiAwXTxicj4NCmlfcGlub8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoCAzYTEgOiA5MjldPGJyPmlf
bmFtZWxlbsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKg
wqDCoCBbMHjCoMKgwqDCoMKgwqAgYiA6IDExXTxicj5pX25hbWXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgW3N0b3JhZ2Uua2V5XTxi
cj5pX2V4dDogZm9mczowIGJsa2FkZHI6NjkzNTExIGxlbjoxPGJyPmlfYWRkclswXcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoCA2OTM1
MTEgOiA2ODk0ODY1XTxicj4NCmlfYWRkclsxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBdPGJyPmlfYWRk
clsyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDC
oCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBdPGJyPmlfYWRkclszXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBd
PGJyPmlfbmlkWzBdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDAgOiAwXTxicj4NCmlfbmlkWzFdwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKg
wqDCoMKgIDAgOiAwXTxicj5pX25pZFsyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIFsweMKgwqDCoMKgwqDCoCAwIDogMF08YnI+aV9uaWRb
M13CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqDCoMKgIMKgwqDC
oCBbMHjCoMKgwqDCoMKgwqAgMCA6IDBdPGJyPmlfbmlkWzRdwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgWzB4wqDCoMKgwqDCoMKgIDAgOiAw
XTxicj4NCjxicj48YnI+RG9uZS48YnI+PC9kaXY+DQo=
--001a11c308ec068c1e050039a83c--


--===============7453914075522493236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7453914075522493236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============7453914075522493236==--
