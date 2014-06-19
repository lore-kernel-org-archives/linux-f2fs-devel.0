From: Brian Chadwick <brianchad@westnet.com.au>
Subject: SELinux context not working
Date: Thu, 19 Jun 2014 20:32:43 +1000
Message-ID: <53A2BC4B.9040203@westnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <brianchad@westnet.com.au>) id 1WxZeI-00078a-Kr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 10:32:54 +0000
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.224])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WxZeG-0000k9-KD for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Jun 2014 10:32:54 +0000
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

Hi

I cant get file contexts to work with F2FS. I have tried a variety of =

kernels up to the latest 3.16rc1 with the Security Labels option =

selected in the config. I am using the latest git of f2fs-tools.

But when I try to set a security context I get the following:

chcon: failed to change context of =91/mnt/f2fs/sig=92 to =

=91system_u:--reference=3D/home/brian/sig:unlabeled_t:s0=92: Operation not =

supported

cp -a also seems unable to set the correct context.

Is there a bug or am I missing something?

mount details are:

/dev/sda6 on /mnt/f2fs type f2fs =

(rw,relatime,background_gc=3Don,user_xattr,acl,active_logs=3D6)

Kind regards

Brian Chadwick

---------------------------------------------------------------------------=
---
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
