From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Date: Mon, 30 Jul 2018 08:43:10 -0700
Message-ID: <20180730154310.GA4685@bombadil.infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
 <20180619031257.GA12527@linux.intel.com>
 <20180619092230.GA1438@bombadil.infradead.org>
 <20180619164037.GA6679@linux.intel.com>
 <20180619171638.GE1438@bombadil.infradead.org>
 <20180627110529.GA19606@bombadil.infradead.org>
 <20180627194438.GA20774@linux.intel.com>
 <20180725210323.GB1366@bombadil.infradead.org>
 <20180727172035.GA13586@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727172035.GA13586@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>, zwisler@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jul 27, 2018 at 11:20:35AM -0600, Ross Zwisler wrote:
> Okay, the next failure I'm hitting is with DAX + XFS + generic/344.  It
> doesn't happen every time, but I can usually recreate it within 10 iterations
> of the test.  Here's the failure:

Thanks.  I've made some progress with this; the WARNing is coming from
a vm_insert_* mkwrite call.  Inserting sufficient debugging code has
let me determine we still have a zero_pfn in the page table when we're
trying to insert a new PFN.
