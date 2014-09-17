From: Patrick Houle <buddlespit@gmail.com>
Subject: systemd-fsck and f2fs
Date: Wed, 17 Sep 2014 19:17:11 -0400
Message-ID: <2173116.zc0VPd5yib@pats-main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <buddlespit@gmail.com>) id 1XUOTR-0005im-HY
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Sep 2014 23:17:21 +0000
Received: from mail-pd0-f169.google.com ([209.85.192.169])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XUOTQ-0008AB-Q3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Sep 2014 23:17:21 +0000
Received: by mail-pd0-f169.google.com with SMTP id fp1so91671pdb.14
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 17 Sep 2014 16:17:15 -0700 (PDT)
Received: from pats-main.localnet (ip68-10-252-83.hr.hr.cox.net.
	[68.10.252.83]) by mx.google.com with ESMTPSA id
	ix1sm17878032pbc.60.2014.09.17.16.17.13
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 17 Sep 2014 16:17:14 -0700 (PDT)
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

I know that your master branch has fixed the systemd-fsck and f2fs 
problem with the "fsck.f2fs: invalid option -- 'a'". But your latest tag is 
1.3.0 from 2/2014 which doesn't contain the fix in your master branch. 
Any idea when this will be added or updated? I know I could just 
download the git and compile it myself, but that will still leave a 
buggy package in the archlinux repo.

Patrick Houle
buddlespit@gmail.com

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
