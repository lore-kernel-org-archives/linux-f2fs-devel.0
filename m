From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: replace ktype default_attrs with
 default_groups
Date: Thu, 13 Jun 2019 14:53:09 +0800
Message-ID: <907b6488-e214-1543-28db-20f9f9d01557@huawei.com>
References: <20190607174041.11201-1-kimbrownkd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJbw-0001dz-AM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:53:24 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJbt-00BBgH-GP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:53:22 +0000
In-Reply-To: <20190607174041.11201-1-kimbrownkd@gmail.com>
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
To: Kimberly Brown <kimbrownkd@gmail.com>, jaegeuk@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2019/6/8 1:40, Kimberly Brown wrote:
> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace the default_attrs fields in f2fs_sb_ktype
> and f2fs_feat_ktype with default_groups. Use the ATTRIBUTE_GROUPS macro
> to create f2fs_groups and f2fs_feat_groups.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
