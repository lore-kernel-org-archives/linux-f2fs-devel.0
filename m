From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: surround fault_injection ralted
 option parsing using CONFIG_F2FS_FAULT_INJECTION
Date: Tue, 11 Sep 2018 18:30:25 +0800
Message-ID: <f28b0638-d3ca-215b-60b7-a08a4aee9d08@huawei.com>
References: <20180910234750.2971-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fzfwR-0004mF-SL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 10:30:43 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzfwP-00EHoX-CD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 10:30:43 +0000
In-Reply-To: <20180910234750.2971-1-cgxu519@gmx.com>
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
To: Chengguang Xu <cgxu519@gmx.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/9/11 7:47, Chengguang Xu wrote:
> It's a little bit strange when fault_injection related
> options fail with -EINVAL which were already disabled
> from config, so surround all fault_injection related option
> parsing code using CONFIG_F2FS_FAULT_INJECTION. Meanwhile,
> slightly change warning message to keep consistency with
> option POSIX_ACL and FS_XATTR.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
