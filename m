From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix double count on issued discard
 commands
Date: Tue, 12 Sep 2017 10:11:57 -0700
Message-ID: <20170912171157.GA2597@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170912042916.GA95671@jaegeuk-macbookpro.roam.corp.google.com>
 <20170911033845.53701-1-jaegeuk@kernel.org>
 <b6550c76-448a-fa48-eef8-3abcc2835b30@huawei.com>
 <6209aa5a-4d45-ac2b-448a-4b405dfb25d1@huawei.com>
 <CGME20170912042935epcas1p4630737028cc7b9536a0c688c92084e84@epcms1p7>
 <20170912043423epcms1p72de7da42985bf53e94e50ea8474b682c@epcms1p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1drojE-0001up-1b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 17:12:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1drojD-0000Op-8n
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 17:12:03 +0000
Content-Disposition: inline
In-Reply-To: <20170912043423epcms1p72de7da42985bf53e94e50ea8474b682c@epcms1p7>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Daeho Jeong <daeho.jeong@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 09/12, Daeho Jeong wrote:
> > Yeah,=A0that's=A0exactly=A0like=A0what=A0I=A0made=A0a=A0mistake=A0befor=
e.
> > I=A0should=A0have=A0mentioned=A0that=A0earlier.=A0:)
> =

> Or I think the previous code which used "iter++" might be right.
> You might just want to check the fixed number of small discards, DISCARD_=
ISSUE_RATE,
> when issue_cond is "true".
> =

> Anyways, I have another question about this function.
> How about just issuing, not checking whether it is idle, the fixed number=
 of small
> discards, DISCARD_ISSUE_RATE, when issue_cond is "true".
> Actually, the discard commands will be issued as "asynchronous" requests,
> which has a low priority in the I/O scheduler,
> so the performance degradation of other threads by doing this will not be=
 much severe,
> but we can make the performance of the storage device better even if ther=
e is no idle.

I don't think I/O scheduler can efficiently prioritize discard commands and=
 user
requests. The proper way that we can do would be waiting for idle time at t=
his
moment.

Thanks,

> =

> I am just worried about the storage device I/O performance gets worse =

> under I/O intensive senario where there is no idle
> =

> Thanks,

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
