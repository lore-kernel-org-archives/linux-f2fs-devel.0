From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] fsck.f2fs: write checkpoint out of place
 first
Date: Mon, 30 Jul 2018 14:41:09 +0800
Message-ID: <fc6f7753-8d2c-6727-793d-8d197e4a0717@huawei.com>
References: <20180730104645.95429-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fk1rq-0002Jw-Ld
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Jul 2018 06:41:18 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fk1ro-002pgI-Jy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Jul 2018 06:41:18 +0000
In-Reply-To: <20180730104645.95429-1-guoweichao@huawei.com>
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
To: Weichao Guo <guoweichao@huawei.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Weichao,

On 2018/7/30 18:46, Weichao Guo wrote:

Could you check and adjust your server's date, it looks like we are receiving
patch from future. ;)

> We may encounter both checkpoints invalid in such a case:
> 1. write checkpoint A, B, C;
> 2. sudden power-cut during write checkpoint D;
> 3. fsck changes the total block count of checkpoint C;
> 4. sudden power-cut during fsck write checkpoint C in place
> 
>  ---------           ---------
> |  ver C  |         |  ver D  |
> |   ...   |         |   ...   |
> | content |         | content |
> |   ...   |         |   ...   |
> |  ver C  |         |         |
> |  ver A  |         |  ver B  |
>  ---------           ---------
> 
> As the total # of checkpoint C is changed, an old cp block
> like ver A or an invalid cp block may be referenced.
> To avoid both checkpoints invalid, and considering fsck should
> not update the checkpoint version, fsck could write checkpoint
> out of place first and then write checkpoint in place. This
> makes sure the file system is fixed by fsck and at least one
> of the two checkpoints is valid.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
