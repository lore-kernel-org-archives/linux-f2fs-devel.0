From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 2/3] f2fs: introduce FITRIM in f2fs_ioctl
Date: Tue, 30 Sep 2014 14:01:58 +0800
Message-ID: <006001cfdc74$178dcdc0$46a96940$@samsung.com>
References: <1411447990-37919-1-git-send-email-jaegeuk@kernel.org>
	<1411447990-37919-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XYqW2-0001zE-SL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Sep 2014 06:02:26 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XYqW1-0000Vc-IK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Sep 2014 06:02:26 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NCP00FL0A3TTJ50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Sep 2014 15:02:17 +0900 (KST)
In-reply-to: <1411447990-37919-2-git-send-email-jaegeuk@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, September 23, 2014 12:53 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/3] f2fs: introduce FITRIM in f2fs_ioctl
> 
> This patch introduces FITRIM in f2fs_ioctl.
> In this case, f2fs will issue small discards and prefree discards as many as
> possible for the given area.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> +
>  	/* zero block will be discarded through the prefree list */
>  	if (!se->valid_blocks || se->valid_blocks == max_blocks)
>  		return;
> 
> +	dmap = kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);

We can afford 64 bytes allocation in stack, how about altering dmap to a local
array to reduce memory pressure at that moment and avoid delay of allocation?

> +	if (!dmap)
> +		return;
> +



------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
