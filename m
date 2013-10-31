From: Zachary <zacharyw09264@gmail.com>
Subject: F2FS Superblock Locations
Date: Wed, 30 Oct 2013 21:06:14 -0400
Message-ID: <CAECMkcPVofeNqT=9jYp5arM5_EikERojWdj+tEqKzecWh4nZRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6782795545298572766=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zacharyw09264@gmail.com>) id 1VbgiK-0002Er-KT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 01:06:20 +0000
Received: from mail-oa0-f43.google.com ([209.85.219.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbgiK-0002AD-1w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 01:06:20 +0000
Received: by mail-oa0-f43.google.com with SMTP id m1so2373386oag.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 30 Oct 2013 18:06:14 -0700 (PDT)
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

--===============6782795545298572766==
Content-Type: multipart/alternative; boundary=047d7b5d47406b514d04e9ff0e97

--047d7b5d47406b514d04e9ff0e97
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Recently I was checking the file format for F2FS and noticed that the
superblocks' location on the partition was both at the beginning.  This
means that if a large portion of the partition is corrupted, then it is
possible for both superblocks to be destroyed.  From my understanding of
other filesystems, they prevent that by spreading out the superbolock
backups across the partition so that it reduces the chances of all
superblocks being destroyed.  Has this been noticed before or am I mistaken
in some way?

Thank you,
Zachary Winnerman

--047d7b5d47406b514d04e9ff0e97
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>Recently I was checking the file format for =
F2FS and noticed that the superblocks&#39; location on the partition was bo=
th at the beginning.=A0 This means that if a large portion of the partition=
 is corrupted, then it is possible for both superblocks to be destroyed.=A0=
 From my understanding of other filesystems, they prevent that by spreading=
 out the superbolock backups across the partition so that it reduces the ch=
ances of all superblocks being destroyed.=A0 Has this been noticed before o=
r am I mistaken in some way?<br>
<br>Thank you,<br>Zachary Winnerman<br></div>

--047d7b5d47406b514d04e9ff0e97--


--===============6782795545298572766==
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
--===============6782795545298572766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6782795545298572766==--
