From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/6] f2fs: support in batch multi blocks preallocation
Date: Wed, 11 May 2016 11:00:57 +0800
Message-ID: <7a11f4d0-3e49-f38d-de08-853b13552ce4@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
 <20160509230037.GA6889@jaegeuk.gateway>
 <bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
 <20160510214125.GA9867@jaegeuk.gateway>
 <705bb492-b510-462e-fef3-d2f66dbb871f@huawei.com>
 <20160511023224.GA15972@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160511023224.GA15972@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/5/11 10:32, Jaegeuk Kim wrote:
> On Wed, May 11, 2016 at 10:22:05AM +0800, Chao Yu wrote:
>> On 2016/5/11 5:41, Jaegeuk Kim wrote:
>>> +
>>> +	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
>>> +
>>> +	for (; count > 0; dn->ofs_in_node++) {
>>> +		block_t blkaddr =
>>> +			datablock_addr(dn->node_page, dn->ofs_in_node);
>>> +		if (blkaddr == NULL_ADDR) {
>>> +			dn->data_blkaddr = NEW_ADDR;
>>> +			__set_data_blkaddr(dn);
>>> +			count--;
>>> +		}
>>> +	}
>>
>> Should let ofs_in_node increase to offset where blkaddr = NULL_ADDR in
>> ENOSPC case or increase to end_offset in normal case, right?
> 
> hehe, I could get some errors on this patch. :)
> Finally, I've made a patch which passes xfstests and fsstress.
> Could you find the latest ones?

OK, I will check them.
Thanks for your rework. :)

Thanks,

> 
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test
> 
>>
>> Thanks,
> .
> 
