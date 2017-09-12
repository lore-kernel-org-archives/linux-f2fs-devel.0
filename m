From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double count on issued discard
 commands
Date: Tue, 12 Sep 2017 04:34:23 +0000
Message-ID: <20170912043423epcms1p72de7da42985bf53e94e50ea8474b682c@epcms1p7>
References: <20170912042916.GA95671@jaegeuk-macbookpro.roam.corp.google.com>
        <20170911033845.53701-1-jaegeuk@kernel.org>
        <b6550c76-448a-fa48-eef8-3abcc2835b30@huawei.com>
        <6209aa5a-4d45-ac2b-448a-4b405dfb25d1@huawei.com>
        <CGME20170912042935epcas1p4630737028cc7b9536a0c688c92084e84@epcms1p7>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170912042916.GA95671@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

> Yeah, that's exactly like what I made a mistake before.

> I should have mentioned that earlier. :)



Or I think the previous code which used "iter++" might be right.

You might just want to check the fixed number of small discards, DISCARD_ISSUE_RATE,

when issue_cond is "true".



Anyways, I have another question about this function.

How about just issuing, not checking whether it is idle, the fixed number of small

discards, DISCARD_ISSUE_RATE, when issue_cond is "true".

Actually, the discard commands will be issued as "asynchronous" requests,

which has a low priority in the I/O scheduler,

so the performance degradation of other threads by doing this will not be much severe,

but we can make the performance of the storage device better even if there is no idle.



I am just worried about the storage device I/O performance gets worse 

under I/O intensive senario where there is no idle



Thanks,
