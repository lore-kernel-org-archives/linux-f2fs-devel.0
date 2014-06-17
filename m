From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: refactor flush_nat_entries codes for
 reducing NAT writes
Date: Tue, 17 Jun 2014 10:33:12 +0800
Message-ID: <002301cf89d4$97aaf7f0$c700e7d0$@samsung.com>
References: <001201cf87c6$92b9fad0$b82df070$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WwjDu-0004Oa-2j
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Jun 2014 02:34:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WwjDr-0001jI-Vo
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Jun 2014 02:34:09 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N7A0086CKGM1V00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Jun 2014 11:33:58 +0900 (KST)
In-reply-to: <001201cf87c6$92b9fad0$b82df070$@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi all,

There are problem in this patch, please ignore this patch, sorry for the noise.
I will resend later.

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Saturday, June 14, 2014 7:48 PM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: refactor flush_nat_entries codes for reducing NAT writes
> 
> Although building NAT journal in cursum reduce the read/write work for NAT
> block, but previous design leave us lower performance when write checkpoint
> frequently for these cases:
> 1. if journal in cursum has already full, it's a bit of waste that we flush all
>    nat entries to page for persistence, but not to cache any entries.
> 2. if journal in cursum is not full, we fill nat entries to journal util
>    journal is full, then flush the left dirty entries to disk without merge
>    journaled entries, so these journaled entries may be flushed to disk at next
>    checkpoint but lost chance to flushed last time.
> 
> In this patch we merge dirty entries located in same NAT block to nat entry set,
> and linked all set to list, sorted ascending order by entries' count of set.
> Later we flush entries in sparse set into journal as many as we can, and then
> flush merged entries to disk.
> 



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
