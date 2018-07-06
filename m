From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v14 68/74] dax: Convert dax_lock_page to XArray
Date: Fri, 6 Jul 2018 06:04:07 -0700
Message-ID: <20180706130407.GA18395@bombadil.infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
 <20180617020052.4759-69-willy@infradead.org>
 <20180629173055.GA2973@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180629173055.GA2973@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jun 29, 2018 at 11:30:55AM -0600, Ross Zwisler wrote:
> On Sat, Jun 16, 2018 at 07:00:46PM -0700, Matthew Wilcox wrote:
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > ---
> <>
> > +static void *dax_make_page_entry(struct page *page, void *entry)
> > +{
> > +	pfn_t pfn = page_to_pfn_t(page);
> > +	return dax_make_entry(pfn, dax_is_pmd_entry(entry));
> > +}
> 
> This function is defined and never used, so we get:
> 
> fs/dax.c:106:14: warning: ‘dax_make_page_entry’ defined but not used [-Wunused-function]
>  static void *dax_make_page_entry(struct page *page, void *entry)
>   ^~~~~~~~~~~~~~~~~~~

Yeah, it was used in one of the functions Dan added, then removed.
I understand he's planning on bringing that back before 4.19 and I'm
going to rebase on top of that, so I've left it there for now.
