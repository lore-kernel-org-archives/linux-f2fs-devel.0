From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: add a rw_sem to cover quota flag
 changes
Date: Tue, 4 Jun 2019 17:48:52 +0800
Message-ID: <c4348b1c-02ba-44e7-598c-e2435e53077d@huawei.com>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
 <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hY6BQ-00086h-UW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jun 2019 09:56:44 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hY6BO-00EvkP-Fz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jun 2019 09:56:44 +0000
In-Reply-To: <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
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

On 2019/5/31 1:57, Jaegeuk Kim wrote:
> thread 1:                        thread 2:
> writeback                        checkpoint
> set QUOTA_NEED_FLUSH
>                                  clear QUOTA_NEED_FLUSH
> f2fs_dquot_commit
> dquot_commit
> clear_dquot_dirty
>                                  f2fs_quota_sync
>                                  dquot_writeback_dquots
> 				 nothing to commit
> commit_dqblk
> quota_write
> f2fs_quota_write
> waiting for f2fs_lock_op()
> 				 pass __need_flush_quota
>                                  (no F2FS_DIRTY_QDATA)
> 
> -> up-to-date quota is not written
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
