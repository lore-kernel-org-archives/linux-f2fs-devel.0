From: syzbot <syzbot+d154ec99402c6f628887@syzkaller.appspotmail.com>
Subject: Re: kernel BUG at fs/f2fs/node.c:LINE!
Date: Mon, 23 Apr 2018 23:04:01 -0700
Message-ID: <000000000000bec77e056a91eb55@google.com>
References: <20180424060137.GA57142@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424060137.GA57142@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

syzbot tried to test the proposed patch but build/boot failed:

patch is already applied


Tested on  
git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/dev-test  
commit
65b966f58e8264477da6c8b70703ce362cb1f8f0 (Tue Apr 24 05:02:31 2018 +0000)
f2fs: give message and set need_fsck given broken node id

compiler: gcc (GCC) 8.0.1 20180413 (experimental)
Patch: https://syzkaller.appspot.com/x/patch.diff?id=5525459446005760
