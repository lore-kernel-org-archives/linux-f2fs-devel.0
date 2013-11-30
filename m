From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: readahead contiguous pages for
 restore_node_summary
Date: Sat, 30 Nov 2013 14:12:56 +0900
Message-ID: <1385788376.2417.63.camel@kjgkr>
References: <000101cee757$6f3b4790$4db1d6b0$@samsung.com>
 <1385530195.2417.22.camel@kjgkr> <002f01ceeb46$8758b9a0$960a2ce0$@samsung.com>
 <1385540365.2417.28.camel@kjgkr> <003001ceebd9$07157380$15405a80$@samsung.com>
 <1385609608.2417.38.camel@kjgkr> <003101ceebfe$bab50890$301f19b0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <003101ceebfe$bab50890$301f19b0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=27=E8=B0=AD=E5=A7=9D=27?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

[snip]
> > > So how about add all pages of page list to node_inode's address space by
> > > add_to_page_cache_lru() with arg sum_entry->nid?
> > 
> > I don't think it's proper way to use add_to_page_cache_lru() directly.
> 
> This is the way used in VM readahead(i.e. read_pages/mpage_readpages/
> read_cache_pages).
> So what you worry about is that using lonely add_to_page_cache_lru()
> may cause exception, is it?

Right, what I meant was that, IMO, we should avoid copy and paste MM
codes, but use its wrappers, exported symbols, as much as possible.

> > > > > >
> > > > > > So how about writing ra_node_pages() which use the node_inode's page
> > > > > > cache?
> > > > >
> > > > > Hmm, so ra_node_pages is introduced for read node_inode's pages which are
> > > > > logical contiguously? and it also could take place of ra_node_page?
> > > >
> > > > Ah. The ra_node_page() read a node page ahead for a given node id.
> > > > So it doesn't match exactly between ra_node_page() and ra_node_pages()
> > > > that I suggested.
> > > > So how about reading node pages and then caching some of them in the
> > > > page cache, node_inode's address space?
> > >
> > > Got it,
> > > If we do not use the method above, we should search the NAT for nid number
> > > as the index of node_inode's page by the specified node page blkaddr, that costs
> > > a lot.
> > > How do you think?
> > 
> > 1. grab_cache_page(node_footer->nid);
> > 2. memcpy();
> > 3. SetPageUptodate();
> > 4. f2fs_put_page();
> 
> It could be.
> 
> This make ra_node_pages() synchronized, because we should read node_footer->nid
> from updated node page before we cache node pages, and we will still use page list to
> pass the updated page.
> 
> Why not introduce f2fs_cache_node_pages() include your code to cache node pages after
> ra_node_pages()?

Ok, right.
I'll test again and then merge this patch. :)

-- 
Jaegeuk Kim
Samsung
