From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: avoid dead loop in function
 find_fsync_dnodes
Date: Mon, 18 Dec 2017 20:24:48 +0800
Message-ID: <a4a82e39-daaa-3c80-cb54-aa33952565ce@huawei.com>
References: <1513324616-21058-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eQuTv-0006Km-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 12:25:19 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eQuTt-00078n-SA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 12:25:19 +0000
In-Reply-To: <1513324616-21058-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2017/12/15 15:56, Yunlei He wrote:
> Came across a dead loop in recovery like this:
> 
> ......
> [   24.680480s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597696
> [   24.698394s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597697
> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724334s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724365s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724395s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> [   24.724426s][pid:320,cpu0,init]find_fsync_dnodes: blkaddr =13597698
> ......
> 
> Mount process will block in dead loop and fsck can do nothing with this
> error, This patch abandon recovery if node chain is cyclical.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
