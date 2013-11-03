From: Zachary <zacharyw09264@gmail.com>
Subject: dentry Hash Method
Date: Sun, 3 Nov 2013 02:47:28 -0500
Message-ID: <CAECMkcMHVx6OrvHSQkURA7wej6vE4LEtDV=TkzkwhZse8GoiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8239736365564089875=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zacharyw09264@gmail.com>) id 1VcsPI-0007VR-7S
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Nov 2013 07:47:36 +0000
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VcsPG-0004KT-4B
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Nov 2013 07:47:36 +0000
Received: by mail-ob0-f171.google.com with SMTP id wn1so6101465obc.30
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 03 Nov 2013 00:47:28 -0700 (PDT)
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

--===============8239736365564089875==
Content-Type: multipart/alternative; boundary=001a11c2d6a0dea4eb04ea4102d2

--001a11c2d6a0dea4eb04ea4102d2
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I was looking at the source code for f2fs with regard to how dentries are
created and I have a question about how the __le32 hash_code is
calculated.  If I have a file like /etc/fstab, would the hash be
f2fs_dentry_hash("/etc/fstab", 10) or f2fs_dentry_hash("fstab", 5) or
something completely different?

Thank you,

Zach

--001a11c2d6a0dea4eb04ea4102d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I was looking at the source code for f2fs wi=
th regard to how dentries are created and I have a question about how the _=
_le32 hash_code is calculated.=A0 If I have a file like /etc/fstab, would t=
he hash be f2fs_dentry_hash(&quot;/etc/fstab&quot;, 10) or f2fs_dentry_hash=
(&quot;fstab&quot;, 5) or something completely different?<br>
<br>Thank you,<br><br>Zach<br></div>

--001a11c2d6a0dea4eb04ea4102d2--


--===============8239736365564089875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
--===============8239736365564089875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============8239736365564089875==--
