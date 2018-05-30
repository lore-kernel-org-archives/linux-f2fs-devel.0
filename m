From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/3] fs: f2fs: changed variable type of
 offset "unsigned" to "loff_t"
Date: Wed, 30 May 2018 22:28:42 +0800
Message-ID: <1e99c70c-49b5-b109-d021-cb97af52c505@kernel.org>
References: <20180529192114.GA7728@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fO26K-0004RE-OX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 14:29:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fO26J-00ByPU-9G
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 14:29:20 +0000
In-Reply-To: <20180529192114.GA7728@willow72>
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
To: youngjun yoo <youngjun.willow@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/5/30 3:21, youngjun yoo wrote:
> clean up checkpatch warning:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
