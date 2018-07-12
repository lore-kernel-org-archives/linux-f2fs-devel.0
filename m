From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: set namelen parameter of
 convert_encrypted_name as unsigned
Date: Thu, 12 Jul 2018 17:46:40 +0800
Message-ID: <dbd85692-ebad-7a70-7fa6-a56f206fbbb3@huawei.com>
References: <20180710144738.167229-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fdYBo-0007Lc-9h
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 09:47:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdYBk-00Fy20-9N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 09:47:08 +0000
In-Reply-To: <20180710144738.167229-1-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/10 22:47, Sheng Yong wrote:
> To avoid overflow, set namelen parameter of convert_encrypted_name as
> unsigned int. convert_encrypted_name() will check if namelen exceeds the
> limitation.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
