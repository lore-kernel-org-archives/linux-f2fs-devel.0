From: guorke <guorke@gmail.com>
Subject: F2FS performance drop than ext4
Date: Sat, 9 Nov 2013 10:31:58 +0800
Message-ID: <CACby0kmwCBK=UcvHSiNrzSBice-6tkagmqr3UwRVO1LfQObufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5831616906325759012=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guorke@gmail.com>) id 1VeyLG-0003mO-JG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 02:32:06 +0000
Received: from mail-lb0-f170.google.com ([209.85.217.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VeyLF-0001u6-NG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 02:32:06 +0000
Received: by mail-lb0-f170.google.com with SMTP id u14so1968712lbd.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 08 Nov 2013 18:31:58 -0800 (PST)
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

--===============5831616906325759012==
Content-Type: multipart/alternative; boundary=001a11348d349aad3204eab54df8

--001a11348d349aad3204eab54df8
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

I test f2fs performace via androbench with lot of f2fs commits.  And i
found that, before commit
bfe35965ecdc6038314d03456b94d9ba451c289d(2013/05/28), the sequential/random
io and sqlite operation performance is better than ext4.  After this
commit, the io performance drop too much,  even test it with the latest
commit.   And test result shows it slower than ext4(~15%), like sequential
read,sqlite insert/update/delete operation,but random write still faster
than ext4(~200%).
F2fs freeze all io operations when do a checkpoint,  but ext4 no this
design,  the checkpoint freeze operation block others metat data update.
in android phone, most application use sqlite , which it caused lot of
fsync/fdatasync. And this sync operation would cause lot of checkpoint
operation , than it caused database perfomance drop. There's some
optimization about writecheckpoint from fs_lock, to semphone. but it is
useless.
any suggestion about it ?

Ps,
1. androbench is  a tool which use to monitor android phone io
performance,  it use fsync/fdatasync to simulate random io and sqlite
database operation.
2. F2fs use default mount option, ext4 use
rw,noatime,noauto_da_alloc,commit=1,data=ordered.


thanks
gourke

--001a11348d349aad3204eab54df8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear all,<br><br>I test f2fs performace via androbenc=
h with lot of f2fs commits.=A0 And i found that, before commit bfe35965ecdc=
6038314d03456b94d9ba451c289d(2013/05/28), the sequential/random io and sqli=
te operation performance is better than ext4.=A0 After this commit, the io =
performance drop too much,=A0 even test it with the latest commit.=A0=A0 An=
d test result shows it slower than ext4(~15%), like sequential read,sqlite =
insert/update/delete operation,but random write still faster than ext4(~200=
%).=A0=A0=A0 <br>
F2fs freeze all io operations when do a checkpoint,=A0 but ext4 no this des=
ign,=A0 the checkpoint freeze operation block others metat data update.=A0=
=A0 in android phone, most application use sqlite , which it caused lot of =
fsync/fdatasync. And this sync operation would cause lot of checkpoint oper=
ation , than it caused database perfomance drop. There&#39;s some optimizat=
ion about writecheckpoint from fs_lock, to semphone. but it is useless.<br>
</div>any suggestion about it ?<br><div><br>Ps, <br>1. androbench is=A0 a t=
ool which use to monitor android phone io performance,=A0 it use fsync/fdat=
async to simulate random io and sqlite database operation.<br>2. F2fs use d=
efault mount option, ext4 use=A0 rw,noatime,noauto_da_alloc,commit=3D1,data=
=3Dordered.<br>
<br><br></div><div>thanks<br></div><div>gourke<br></div></div>

--001a11348d349aad3204eab54df8--


--===============5831616906325759012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
--===============5831616906325759012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============5831616906325759012==--
