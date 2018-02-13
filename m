From: Ashlie Martinez <ashmrtn@utexas.edu>
Subject: fsck.f2fs result parsing
Date: Tue, 13 Feb 2018 13:46:40 -0600
Message-ID: <CAFk8rvbSG-+=x-wNmPtGsxYcJr5PD1rmg0fd09Bs-VHmSuL0Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <ashmrtn@utexas.edu>) id 1elgtQ-000822-5Z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 20:09:32 +0000
Received: from mail-vk0-f65.google.com ([209.85.213.65])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1elgtO-0004KH-DI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Feb 2018 20:09:32 +0000
Received: by mail-vk0-f65.google.com with SMTP id t126so4401645vkb.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Feb 2018 12:09:30 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hello,

I am a student at the University of Texas at Austin's CS department
and I am working on a new, record-and-replay, file system agnostic
crash consistency test harness called CrashMonkey [1][2]. As part of
this project, I need to run various file system checkers and return
one of several different enums that represents the results of the file
system checker run. The basic result enums mirror those in the man
page for fsck(8), and include values for "no errors found", "errors
corrected", "errors left uncorrected", and a catch-all "other error".

The man page for fsck.f2fs shows that it only returns either 0 or -1
for "success" or "failure". Is there any way I could parse some of the
output of fsck.f2fs (either stdout or stderr) to determine the outcome
of fsck.f2fs so that it can be categorized into the enums given above?
If so, where should I look for the relevant strings to parse for?

[1] https://github.com/utsaslab/crashmonkey
[2] https://www.usenix.org/conference/hotstorage17/program/presentation/martinez

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
