From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: clear cold data flag if IO is not
 counted
Date: Wed, 17 Oct 2018 10:50:48 +0800
Message-ID: <1c88d521-c36d-91d5-b863-d3fae6be4737@huawei.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gCbvM-00021X-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 02:51:04 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCbvK-00AkVt-QJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Oct 2018 02:51:04 +0000
In-Reply-To: <20181017023404.GB77619@jaegeuk-macbookpro.roam.corp.google.com>
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

On 2018/10/17 10:34, Jaegeuk Kim wrote:
> This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.
> 
> If we clear the cold data flag out of the writeback flow, we can miscount
> -1 by end_io.
> 
> Balancing F2FS Async:
>  - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...
> 
> GC thread:                              IRQ
> - move_data_page()
>  - set_page_dirty()
>   - clear_cold_data()
>                                         - f2fs_write_end_io()
>                                          - type = WB_DATA_TYPE(page);
>                                            here, we get wrong type
>                                          - dec_page_count(sbi, type);
>  - f2fs_wait_on_page_writeback()
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
