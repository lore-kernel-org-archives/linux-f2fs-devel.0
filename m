From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove redundant check of page type
 when submit bio
Date: Wed, 7 Feb 2018 19:42:52 +0800
Message-ID: <27a22eeb-0995-f7e1-d636-9aa649edc63d@kernel.org>
References: <25158d37.852.161687d6bab.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejO88-0005fk-Lr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 11:43:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejO87-00076Z-Qi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 11:43:12 +0000
In-Reply-To: <25158d37.852.161687d6bab.Coremail.kernelpatch@126.com>
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
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/2/6 8:21, Tiezhu Yang wrote:
> This patch removes redundant check of page type when submit bio to
> make the logic more clear.
> 
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
