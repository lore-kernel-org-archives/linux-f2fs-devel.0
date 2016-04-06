From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.6-rc2/fs/f2fs/checkpoint.c:214]: (style)
	Redundant condition
Date: Wed, 6 Apr 2016 18:19:40 +0000
Message-ID: <DUB128-W837A071E735105BA105A379C9F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dcb314@hotmail.com>) id 1ans3Q-00057S-1V
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Apr 2016 18:19:48 +0000
Received: from dub004-omc1s7.hotmail.com ([157.55.0.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ans3P-0004p5-7R
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Apr 2016 18:19:48 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "cm224.lee@samsung.com" <cm224.lee@samsung.com>, "chao2.yu@samsung.com" <chao2.yu@samsung.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hello there,

linux-4.6-rc2/fs/f2fs/checkpoint.c:214]: (style) Redundant condition: page.=
 '!page || (page && !PageUptodate(page))' is equivalent to '!page || !PageU=
ptodate(page)'

Source code is

=A0=A0=A0 if (!page || (page && !PageUptodate(page)))

Also,

linux-4.6-rc2/fs/f2fs/data.c:1489]: (style) Redundant condition: !err. 'err=
 || (!err && dn.data_blkaddr=3D=3DNULL_ADDR)' is equivalent to 'err || dn.d=
ata_blkaddr=3D=3DNULL_ADDR'

Source code is

=A0=A0 if (err || (!err && dn.data_blkaddr =3D=3D NULL_ADDR)) {



Regards

David Binderman
 		 	   		  =

---------------------------------------------------------------------------=
---
