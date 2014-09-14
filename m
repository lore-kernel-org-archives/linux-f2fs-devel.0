From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 09/10] f2fs: use MAX_BIO_BLOCKS(sbi)
Date: Sun, 14 Sep 2014 15:34:51 -0700
Message-ID: <1410734091.917.26.camel@joe-AO725>
References: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
	 <1410732864-53069-9-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410732864-53069-9-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sun, 2014-09-14 at 15:14 -0700, Jaegeuk Kim wrote:
> This patch cleans up a simple macro.

There seems to be many different types used here.

	MAX_BIO_BLOCKS returns unsigned int
	bio_blocks is int,
	blocks_per_seg is unsigned int,
	ra_meta_pages(,,int,)
	nr_pages_to_skip uses int
	nr_pages_to_write returns a long

Perhaps it'd be nicer to standardize the type
so there'd be fewer promotions/implicit casts.
