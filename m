From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Keep alloc_valid_block_count in sync
Date: Tue, 10 Jul 2018 14:17:31 +0800
Message-ID: <55de7e3a-9c21-4601-6ee7-83ba97a2509e@huawei.com>
References: <20180710033242.177557-1-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fclyu-0004zL-IY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 06:18:36 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fclys-004Evo-VY
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 06:18:36 +0000
In-Reply-To: <20180710033242.177557-1-drosen@google.com>
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
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org

On 2018/7/10 11:32, Daniel Rosenberg wrote:
> If we attempt to request more blocks than we have room for, we try to
> instead request as much as we can, however, alloc_valid_block_count
> is not decremented to match the new value, allowing it to drift higher
> until the next checkpoint. This always decrements it when the requested
> amount cannot be fulfilled.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Good catch, thanks for the fixing. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
