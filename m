From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: refactor __find_rev_next_{zero}_bit
Date: Thu, 22 Oct 2015 19:24:01 +0800
Message-ID: <031b01d10cbc$41897f10$c49c7d30$@samsung.com>
References: <1445462203-44072-1-git-send-email-jaegeuk@kernel.org>
 <20151021222933.GA46426@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151021222933.GA46426@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, October 22, 2015 6:30 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: refactor __find_rev_next_{zero}_bit
> 
> On Wed, Oct 21, 2015 at 02:16:43PM -0700, Jaegeuk Kim wrote:
> > This patch refactors __find_rev_next_{zero}_bit which was disabled previously
> > due to bugs.

Actually I didn't know the history here, could you please explain details
about the bugs? then I can do the review.

Thanks,

> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 106 +++++++++++++++++++++++++-----------------------------
> >  1 file changed, 49 insertions(+), 57 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index f37c212..50afc93 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -29,6 +29,21 @@ static struct kmem_cache *discard_entry_slab;
> >  static struct kmem_cache *sit_entry_set_slab;
> >  static struct kmem_cache *inmem_entry_slab;
> >
> > +static unsigned long __reverse_ulong(unsigned char *str)
> > +{
> > +	unsigned long tmp = 0;
> > +	int shift = 24, idx = 0;
> > +
> > +#if BITS_PER_LONG == 64
> > +	shift = 56;
> > +#endif
> > +	while (shift >= 0) {
> > +		tmp |= (unsigned long)str[idx++] << shift;
> > +		shift -= BITS_PER_BYTE;
> > +	}
> > +	return tmp;
> > +}
> > +
> >  /*
> >   * __reverse_ffs is copied from include/asm-generic/bitops/__ffs.h since
> >   * MSB and LSB are reversed in a byte by f2fs_set_bit.
> > @@ -38,27 +53,31 @@ static inline unsigned long __reverse_ffs(unsigned long word)
> >  	int num = 0;
> >
> >  #if BITS_PER_LONG == 64
> > -	if ((word & 0xffffffff) == 0) {
> > +	if ((word & 0xffffffff00000000) == 0)
> 
> I fixed the sparse warning by modifying:
> 	if ((word & 0xffffffff00000000UL) == 0)
> 
> Thanks,
> 
> >  		num += 32;
> > +	else
> >  		word >>= 32;
> > -	}
> >  #endif
> > -	if ((word & 0xffff) == 0) {
> > +	if ((word & 0xffff0000) == 0)
> >  		num += 16;
> > +	else
> >  		word >>= 16;
> > -	}
> > -	if ((word & 0xff) == 0) {
> > +
> > +	if ((word & 0xff00) == 0)
> >  		num += 8;
> > +	else
> >  		word >>= 8;
> > -	}
> > +
> >  	if ((word & 0xf0) == 0)
> >  		num += 4;
> >  	else
> >  		word >>= 4;
> > +
> >  	if ((word & 0xc) == 0)
> >  		num += 2;
> >  	else
> >  		word >>= 2;
> > +
> >  	if ((word & 0x2) == 0)
> >  		num += 1;
> >  	return num;
> > @@ -68,26 +87,16 @@ static inline unsigned long __reverse_ffs(unsigned long word)
> >   * __find_rev_next(_zero)_bit is copied from lib/find_next_bit.c because
> >   * f2fs_set_bit makes MSB and LSB reversed in a byte.
> >   * Example:
> > - *                             LSB <--> MSB
> > - *   f2fs_set_bit(0, bitmap) => 0000 0001
> > - *   f2fs_set_bit(7, bitmap) => 1000 0000
> > + *                             MSB <--> LSB
> > + *   f2fs_set_bit(0, bitmap) => 1000 0000
> > + *   f2fs_set_bit(7, bitmap) => 0000 0001
> >   */
> >  static unsigned long __find_rev_next_bit(const unsigned long *addr,
> >  			unsigned long size, unsigned long offset)
> >  {
> > -	while (!f2fs_test_bit(offset, (unsigned char *)addr))
> > -		offset++;
> > -
> > -	if (offset > size)
> > -		offset = size;
> > -
> > -	return offset;
> > -#if 0
> >  	const unsigned long *p = addr + BIT_WORD(offset);
> >  	unsigned long result = offset & ~(BITS_PER_LONG - 1);
> >  	unsigned long tmp;
> > -	unsigned long mask, submask;
> > -	unsigned long quot, rest;
> >
> >  	if (offset >= size)
> >  		return size;
> > @@ -97,14 +106,9 @@ static unsigned long __find_rev_next_bit(const unsigned long *addr,
> >  	if (!offset)
> >  		goto aligned;
> >
> > -	tmp = *(p++);
> > -	quot = (offset >> 3) << 3;
> > -	rest = offset & 0x7;
> > -	mask = ~0UL << quot;
> > -	submask = (unsigned char)(0xff << rest) >> rest;
> > -	submask <<= quot;
> > -	mask &= submask;
> > -	tmp &= mask;
> > +	tmp = __reverse_ulong((unsigned char *)p);
> > +	tmp &= ~0UL >> offset;
> > +
> >  	if (size < BITS_PER_LONG)
> >  		goto found_first;
> >  	if (tmp)
> > @@ -112,42 +116,34 @@ static unsigned long __find_rev_next_bit(const unsigned long *addr,
> >
> >  	size -= BITS_PER_LONG;
> >  	result += BITS_PER_LONG;
> > +	p++;
> >  aligned:
> >  	while (size & ~(BITS_PER_LONG-1)) {
> > -		tmp = *(p++);
> > +		tmp = __reverse_ulong((unsigned char *)p);
> >  		if (tmp)
> >  			goto found_middle;
> >  		result += BITS_PER_LONG;
> >  		size -= BITS_PER_LONG;
> > +		p++;
> >  	}
> >  	if (!size)
> >  		return result;
> > -	tmp = *p;
> > +
> > +	tmp = __reverse_ulong((unsigned char *)p);
> >  found_first:
> > -	tmp &= (~0UL >> (BITS_PER_LONG - size));
> > -	if (tmp == 0UL)		/* Are any bits set? */
> > +	tmp &= (~0UL << (BITS_PER_LONG - size));
> > +	if (!tmp)		/* Are any bits set? */
> >  		return result + size;   /* Nope. */
> >  found_middle:
> >  	return result + __reverse_ffs(tmp);
> > -#endif
> >  }
> >
> >  static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
> >  			unsigned long size, unsigned long offset)
> >  {
> > -	while (f2fs_test_bit(offset, (unsigned char *)addr))
> > -		offset++;
> > -
> > -	if (offset > size)
> > -		offset = size;
> > -
> > -	return offset;
> > -#if 0
> >  	const unsigned long *p = addr + BIT_WORD(offset);
> >  	unsigned long result = offset & ~(BITS_PER_LONG - 1);
> >  	unsigned long tmp;
> > -	unsigned long mask, submask;
> > -	unsigned long quot, rest;
> >
> >  	if (offset >= size)
> >  		return size;
> > @@ -157,40 +153,36 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
> >  	if (!offset)
> >  		goto aligned;
> >
> > -	tmp = *(p++);
> > -	quot = (offset >> 3) << 3;
> > -	rest = offset & 0x7;
> > -	mask = ~(~0UL << quot);
> > -	submask = (unsigned char)~((unsigned char)(0xff << rest) >> rest);
> > -	submask <<= quot;
> > -	mask += submask;
> > -	tmp |= mask;
> > +	tmp = __reverse_ulong((unsigned char *)p);
> > +	tmp |= ~((~0UL << offset) >> offset);
> > +
> >  	if (size < BITS_PER_LONG)
> >  		goto found_first;
> > -	if (~tmp)
> > +	if (tmp != ~0UL)
> >  		goto found_middle;
> >
> >  	size -= BITS_PER_LONG;
> >  	result += BITS_PER_LONG;
> > +	p++;
> >  aligned:
> >  	while (size & ~(BITS_PER_LONG - 1)) {
> > -		tmp = *(p++);
> > -		if (~tmp)
> > +		tmp = __reverse_ulong((unsigned char *)p);
> > +		if (tmp != ~0UL)
> >  			goto found_middle;
> >  		result += BITS_PER_LONG;
> >  		size -= BITS_PER_LONG;
> > +		p++;
> >  	}
> >  	if (!size)
> >  		return result;
> > -	tmp = *p;
> >
> > +	tmp = __reverse_ulong((unsigned char *)p);
> >  found_first:
> > -	tmp |= ~0UL << size;
> > -	if (tmp == ~0UL)        /* Are any bits zero? */
> > +	tmp |= ~(~0UL << (BITS_PER_LONG - size));
> > +	if (tmp == ~0UL)	/* Are any bits zero? */
> >  		return result + size;   /* Nope. */
> >  found_middle:
> >  	return result + __reverse_ffz(tmp);
> > -#endif
> >  }
> >
> >  void register_inmem_page(struct inode *inode, struct page *page)
> > --
> > 2.1.1
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
