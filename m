From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: use unlikely for release case
Date: Mon, 11 Dec 2017 21:16:33 +0800
Message-ID: <6943a64b-44cc-1501-7969-c749574ac839@kernel.org>
References: <CGME20171205083900epcas5p3da0ba06455bf7f17ffacd0b25328aca3@epcas5p3.samsung.com>
 <000c01d36da4$7a9efbe0$6fdcf3a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eONwt-0007kF-HP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 13:16:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eONws-0004ij-NZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Dec 2017 13:16:47 +0000
In-Reply-To: <000c01d36da4$7a9efbe0$6fdcf3a0$@samsung.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: LiFan <fanofcode.li@samsung.com>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/12/5 16:38, LiFan wrote:
> Since the variable release is only nonzero when another unlikely
> case occurs, use unlikely() on it seems logical.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
