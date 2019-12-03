Return-Path: <SRS0=t7e3=ZZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625AEC432C0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Dec 2019 01:35:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28455206F0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Dec 2019 01:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iZtP5Svm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ITJrxCzN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KquqAkqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28455206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ibx6U-0001fy-TH; Tue, 03 Dec 2019 01:35:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <torvalds@linuxfoundation.org>) id 1ibx6T-0001fl-H1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Dec 2019 01:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=; b=iZtP5SvmvJo6QZIk6pTJ/HzmgU
 ikxRg20/quP3jLokh0Xy5T/M4iqx2kDsdKS4oXfCJF3aQpT2Of+YmJQj/Be3wrDbhH1Y71/DBhCCZ
 t3VcDmlSrmpAKhH3E9+aFnuRdr1CJ6ON2o9T7Te7QozfnU/zyFjVl2f71LRKyKaYkcT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=; b=ITJrxCzN7IxXa5kGDCWRYAdz3T
 H+FZ7lDjPyB0vcE6FkbHm76zGCUucLyS4+B+h3cIPOW2NNKZNXLZsy+ZerunxTJQgvC0A5I2/Wkzp
 XynPd4UmIXgjCWb+WlPsfSB+CS9KtW9Z7cpH/Aq5K4ZKQBIGb03jcifgfYQ9ZNZl/vuU=;
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ibx6P-005GKE-3o
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Dec 2019 01:35:49 +0000
Received: by mail-lf1-f68.google.com with SMTP id f16so1503693lfm.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Dec 2019 17:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=;
 b=KquqAkqUVTyG83FELzXx6nZWqrQom0qPebBeM3l4nUnY0IjRxfw5jl9f4rhB4P0Ys1
 yMMjUqHh9Atftq9/aMH7vPLqvTYv5hjkMQeepjJof4arWmddxk+x0kYqi0oEsm1gm01r
 c0+/cFEMdOFDQe0735Al7ThhTziCMU1XmN/7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f16wPMX3Hv5+5LpFCWWiK7eqWkk4a1TMh+b2JYuh2L4=;
 b=YFmsCRgD/pbTKPlbsUwmz0HRk+HUiSStHbvZ0en+abwDx1t/1D+iacym74IHCPuQ+E
 GNXgaeJLNTNLgEQU7vi7VElbtlMET7dmHunBW9t9YqwYWLozas9jd9HwTJdMYeJF16dC
 Bz4tFccBjcjZucXXsK7ZcVEBPuqA4nh8invXpTiTeNX0C0OhpHizibU3QQ4qGrzr+7vA
 JuKCHUTDany7SQC/XMy86jnckVWKjL+eNigoyVAZHhK/hYIT7YeeDWKFFv0Eq20aj98p
 m+nIEavDHbi4e+2ccMWjDAazqedWVHHxVW9NBegWVko2hwkgIEeoN7blCJxcczG83SBN
 UusQ==
X-Gm-Message-State: APjAAAXCv24debBkT+ZdbWrS/USWBfEtN/SsKwK2xhkwglmbJ1dcQ34e
 XtSKdAyPf/hniJzV4b2yFm4auhKPK/c=
X-Google-Smtp-Source: APXvYqyKYHuiqdB9jLY37VzGl6TfkLjkvzTXCVLCM+ObDQN0EOY/d6x3bAOWQsx7N183GzpUAW+h+Q==
X-Received: by 2002:ac2:4476:: with SMTP id y22mr1059165lfl.169.1575335195746; 
 Mon, 02 Dec 2019 17:06:35 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id t143sm364667lff.2.2019.12.02.17.06.33
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 17:06:34 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id s22so1726047ljs.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Dec 2019 17:06:33 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr889870ljj.97.1575335193641;
 Mon, 02 Dec 2019 17:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20191129142045.7215-1-agruenba@redhat.com>
In-Reply-To: <20191129142045.7215-1-agruenba@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Dec 2019 17:06:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
Message-ID: <CAHk-=wj5caXKoukPyM7Zc6A0Q+E-pBGHSV64iZe8t98OerXR_w@mail.gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
X-Headers-End: 1ibx6P-005GKE-3o
Subject: Re: [f2fs-dev] [PATCH v2] fs: Fix page_mkwrite off-by-one errors
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Sage Weil <sage@redhat.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Ilya Dryomov <idryomov@gmail.com>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mtd@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Nov 29, 2019 at 6:21 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> +/**
> + * page_mkwrite_check_truncate - check if page was truncated
> + * @page: the page to check
> + * @inode: the inode to check the page against
> + *
> + * Returns the number of bytes in the page up to EOF,
> + * or -EFAULT if the page was truncated.
> + */
> +static inline int page_mkwrite_check_truncate(struct page *page,
> +                                             struct inode *inode)
> +{
> +       loff_t size = i_size_read(inode);
> +       pgoff_t end_index = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;

This special end_index calculation seems to be redundant.

You later want "size >> PAGE_SHIFT" for another test, and that's
actually the important part.

The "+ PAGE_SIZE - 1" case is purely to handle the "AT the page
boundary is special" case, but since you have to calculate
"offset_in_page(size)" anyway, that's entirely redundant - the answer
is part of that.

So I think it would be better to write the logic as

        loff_t size = i_size_read(inode);
        pgoff_t index = size >> PAGE_SHIFT;
        int offset = offset_in_page(size);

        if (page->mapping != inode->i_mapping)
                return -EFAULT;

        /* Page is wholly past the EOF page */
        if (page->index > index)
                return -EFAULT;
        /* page is wholly inside EOF */
        if (page->index < index)
                return PAGE_SIZE;
        /* bytes in a page? If 0, it's past EOF */
        return offset ? offset : -PAGE_SIZE;

instead. That avoids the unnecessary "round up" part, and simply uses
the same EOF index for everything.

              Linus


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
