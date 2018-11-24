From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: make "f2fs_fault_name[]" const char *
Date: Sat, 24 Nov 2018 18:25:33 +0800
Message-ID: <f8830c39-9a98-7456-dab3-1f82b8fad9ed@huawei.com>
References: <20181124090642.GA10969@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gQV8D-0002Ks-V9
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 10:25:45 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gQV8C-00FEzl-78
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 10:25:45 +0000
In-Reply-To: <20181124090642.GA10969@avx2>
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
To: Alexey Dobriyan <adobriyan@gmail.com>, jaegeuk@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/11/24 17:06, Alexey Dobriyan wrote:
> Those strings are immutable.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
