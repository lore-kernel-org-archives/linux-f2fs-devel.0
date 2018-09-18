From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: add new idle interval timing for
 discard and gc paths
Date: Tue, 18 Sep 2018 11:43:50 +0800
Message-ID: <5b4c0656-d074-b7dc-e067-be7b63dd20ff@huawei.com>
References: <1537169458-30361-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g26vl-0000zF-8z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 03:44:05 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g26vj-00EVbQ-9z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 03:44:04 +0000
In-Reply-To: <1537169458-30361-1-git-send-email-stummala@codeaurora.org>
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
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On 2018/9/17 15:30, Sahitya Tummala wrote:
> This helps to control the frequency of submission of discard and
> GC requests independently, based on the need.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
