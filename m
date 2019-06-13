From: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: INFO: task syz-executor can't die for more than 143
 seconds.
Date: Wed, 12 Jun 2019 19:53:00 -0700
Message-ID: <000000000000c0103a058b2ba0ec@google.com>
References: <000000000000a861f6058b2699e0@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3jLoBXQkbAPUpvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1hbFrR-0007pO-3z
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 02:53:09 +0000
Received: from mail-io1-f72.google.com ([209.85.166.72])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hbFrO-00AzFt-2g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 02:53:07 +0000
Received: by mail-io1-f72.google.com with SMTP id r27so13825877iob.14
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Jun 2019 19:53:05 -0700 (PDT)
In-Reply-To: <000000000000a861f6058b2699e0@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, yuchao0@huawei.com

syzbot has bisected this bug to:

commit 4ddc1b28aac57a90c6426d55e0dea3c1b5eb4782
Author: Chao Yu <yuchao0@huawei.com>
Date:   Wed Jul 25 23:19:48 2018 +0000

     f2fs: fix to restrict mount condition when without CONFIG_QUOTA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f4e49a00000
start commit:   81a72c79 Add linux-next specific files for 20190612
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122f4e49a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa46bbce201b8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8ab2d0f39fb79fe6ca40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250ae3ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1568557aa00000

Reported-by: syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com
Fixes: 4ddc1b28aac5 ("f2fs: fix to restrict mount condition when without  
CONFIG_QUOTA")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
