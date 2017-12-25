From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: return error during fill_super
Date: Mon, 25 Dec 2017 14:12:53 +0800
Message-ID: <70cb524f-dd80-d6ee-b8e8-0ce3ee8f8201@huawei.com>
References: <20171220203956.53166-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eTM0h-0001st-AI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 06:13:15 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eTM0f-0004Bg-7N
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Dec 2017 06:13:15 +0000
In-Reply-To: <20171220203956.53166-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/12/21 4:39, Jaegeuk Kim wrote:
> Let's avoid BUG_ON during fill_super, when on-disk was totall corrupted.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
