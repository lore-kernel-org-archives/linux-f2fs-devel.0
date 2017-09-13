From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double count on issued discard
 commands
Date: Wed, 13 Sep 2017 08:48:30 +0000
Message-ID: <20170913084830epcms1p8a0a01f9de4c8f09730206203b9969a79@epcms1p8>
References: <d2894eac-1fba-daf9-480f-1d0cbef67423@huawei.com>
        <20170912042916.GA95671@jaegeuk-macbookpro.roam.corp.google.com>
        <20170911033845.53701-1-jaegeuk@kernel.org>
        <b6550c76-448a-fa48-eef8-3abcc2835b30@huawei.com>
        <6209aa5a-4d45-ac2b-448a-4b405dfb25d1@huawei.com>
        <20170912043423epcms1p72de7da42985bf53e94e50ea8474b682c@epcms1p7>
        <CGME20170912042935epcas1p4630737028cc7b9536a0c688c92084e84@epcms1p8>
Reply-To: daeho.jeong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <d2894eac-1fba-daf9-480f-1d0cbef67423@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

> Actually, we didn't change priority of discard command, so that it is still
> synchronous IO for I/O scheduler, hence I/O interference will still exist if we
> try to issue discard without IO aware ability.
 
> Of course we can change the priority of discard command to lower, but potential
> issue is that with ROW I/O scheduler in kernel or FTL, async I/O will handle
> very slowly in heavy load scenario, if we are going to trigger sync write IO in
> place in where we're doing async discard, we will face long latency.
 
> Still I think it is worth to build the ability to issue async discard as a part
> of discard policy and later we can adjust policy based on different scenario.
 
> Thanks,

Oh, I see.

f2fs is sending discard requests as "sync" requests, I didn't know that.
Right, I just though in case of CFQ I/O scheduler, but f2fs has to consider the other
schedulers, but CFQ.

Thanks, :)
