From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during
 POR
Date: Thu, 20 Sep 2018 23:40:38 -0700
Message-ID: <20180921064038.GA21481@infradead.org>
References: <20180920094130.124622-1-yuchao0@huawei.com>
 <20180921060629.GA13865@infradead.org>
 <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+9c098bdbed5ba9a68ca5+5507+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1g3F7O-00041k-V6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 06:40:46 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g3F7N-003beM-JF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 06:40:46 +0000
Content-Disposition: inline
In-Reply-To: <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Sep 21, 2018 at 02:20:49PM +0800, Chao Yu wrote:
> No problem, I just plan to.
> 
> Out of curiosity, are you filter some key words like 'recover' in your
> email client to find this so quickly?

No, I just do a quick glanceof lkml every morning, and this just caught
my eye.
