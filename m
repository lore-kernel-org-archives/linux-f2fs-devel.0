From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/6] f2fs: support in batch multi blocks
	preallocation
Date: Tue, 10 May 2016 19:32:24 -0700
Message-ID: <20160511023224.GA15972@jaegeuk.gateway>
References: <20160509115635.123946-1-yuchao0@huawei.com>
	<20160509230037.GA6889@jaegeuk.gateway>
	<bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
	<20160510214125.GA9867@jaegeuk.gateway>
	<705bb492-b510-462e-fef3-d2f66dbb871f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b0Jwx-0006hv-LO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 02:32:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b0Jwv-0007Rq-7z
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 11 May 2016 02:32:35 +0000
Content-Disposition: inline
In-Reply-To: <705bb492-b510-462e-fef3-d2f66dbb871f@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, May 11, 2016 at 10:22:05AM +0800, Chao Yu wrote:
> On 2016/5/11 5:41, Jaegeuk Kim wrote:
> > +
> > +	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
> > +
> > +	for (; count > 0; dn->ofs_in_node++) {
> > +		block_t blkaddr =
> > +			datablock_addr(dn->node_page, dn->ofs_in_node);
> > +		if (blkaddr == NULL_ADDR) {
> > +			dn->data_blkaddr = NEW_ADDR;
> > +			__set_data_blkaddr(dn);
> > +			count--;
> > +		}
> > +	}
> 
> Should let ofs_in_node increase to offset where blkaddr = NULL_ADDR in
> ENOSPC case or increase to end_offset in normal case, right?

hehe, I could get some errors on this patch. :)
Finally, I've made a patch which passes xfstests and fsstress.
Could you find the latest ones?

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

> 
> Thanks,

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
