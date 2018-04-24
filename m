From: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
Date: Mon, 23 Apr 2018 23:42:02 -0700
Message-ID: <000000000000ae37a6056a9273f6@google.com>
References: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3utHeWgkbALUntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1fAreT-0003Th-BJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 06:42:09 +0000
Received: from mail-it0-f72.google.com ([209.85.214.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fAreR-006sN4-Od
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Apr 2018 06:42:09 +0000
Received: by mail-it0-f72.google.com with SMTP id 140-v6so10599452itg.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Apr 2018 23:42:07 -0700 (PDT)
In-Reply-To: <20180424062000.GA57884@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, yuchao0@huawei.com

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to create VM pool: failed to create GCE image: failed to get create  
image operation operation-1524552040215-56a926ecc71d9-3edfeb8b-8abca81c:  
googleapi: Error 403: Rate Limit Exceeded, rateLimitExceeded


Tested on  
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev commit
b549e322861b99f1862fb5f08dfb5e5753a38635 (Sat Apr 21 06:44:59 2018 +0000)
f2fs: check cap_resource only for data blocks

compiler: gcc (GCC) 8.0.1 20180413 (experimental)
Patch: https://syzkaller.appspot.com/x/patch.diff?id=5565179303559168
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
