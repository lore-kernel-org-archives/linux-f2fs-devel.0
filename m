From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/8] f2fs: clear nlink if fail to add_link
Date: Thu, 13 Oct 2016 18:29:00 +0800
Message-ID: <78ec7ed6-47d2-ffe5-d57e-7a67a759ce04@huawei.com>
References: <20161011145706.5028-1-chao@kernel.org>
	<20161011221903.GA92615@jaegeuk>
	<f7223716-7822-67a0-8165-b7d55e06c589@kernel.org>
	<20161012172244.GB98211@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1budIc-0000dU-7f
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 10:31:42 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1budIX-0001ZN-IU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Oct 2016 10:31:42 +0000
In-Reply-To: <20161012172244.GB98211@jaegeuk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/10/13 1:22, Jaegeuk Kim wrote:
> No, it happened xfstests/027 under encrypted mode only.

Got it. :)

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
