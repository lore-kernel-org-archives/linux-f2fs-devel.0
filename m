Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB266CD128A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  6 Apr 2024 05:21:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rsyUI-0005YI-Mc;
	Sat, 06 Apr 2024 05:21:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kent.overstreet@linux.dev>) id 1rsyUH-0005YB-8q
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Apr 2024 05:21:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bhfWeUnybAsPC5w2wnk+v+3mDew6UZBufRKxuTERnpI=; b=E1wC6If3ASsUTZRRNH9/O21dSk
 7AorSeEoAzy4bRsMQkLxZyRcLMlL+Z+mfuF/Qp12G+QEBukYKviD3IxLKLnbV9cjWbHN5cBoA4pPo
 6d+VzHajOpb1jbwBLDd5LqemwNfRmm14rUl4NsgptTnbGBvn3KMh6afhDFP653wA7R3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bhfWeUnybAsPC5w2wnk+v+3mDew6UZBufRKxuTERnpI=; b=DR6N58No9m6C3409EqJYALR1N3
 UGrsdSLSku1TXIncGW27E5zdxLVzKmkTiCDe5QUTZ2rFRz1ExiBd2Oa2O05/kvC8yKo71cinvcV7z
 Tk0M2Z430BHZpJxEVh82v+zcsTemmOaNob+nM8GBXuiyYJPs6X9VKDpGAqFIx/+XqTPM=;
Received: from out-188.mta0.migadu.com ([91.218.175.188])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rsyUC-0004ft-2q for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Apr 2024 05:21:09 +0000
Date: Sat, 6 Apr 2024 01:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1712380852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhfWeUnybAsPC5w2wnk+v+3mDew6UZBufRKxuTERnpI=;
 b=lLPAYrt5fteZomt541z2r9imi7ugwkVNiZC5pZZu3KjNFo/chRlOU1XA+bzccxMdMbIll9
 iA+zhVqapFEEo0NHoRaICnZZ4CQhn70DUUTzecq//OFELR8OzaQySC7v12I2ZtwQTy4tva
 HKowOJToS6St8IaHHb2Zg43DVWkqMkE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Dilger <adilger@dilger.ca>
Message-ID: <2iyoi665o6hogzzlfhs6ets6vq2joh4xi5t3fbcpdmlv2cyrxu@7umadxpnaql7>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
 <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1rsyUC-0004ft-2q
Subject: Re: [f2fs-dev] [PATCH v3 13/13] bcachefs: fiemap: emit new
 COMPRESSED state
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
Cc: linux-bcachefs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 kernel-team@meta.com, Jan Kara <jack@suse.cz>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 01:17:45PM -0600, Andreas Dilger wrote:
> On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy <sweettea-kernel@dorminy.me> wrote:
> > 
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> > ---
> > fs/bcachefs/fs.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > index d2793bae842d..54f613f977b4 100644
> > --- a/fs/bcachefs/fs.c
> > +++ b/fs/bcachefs/fs.c
> > @@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
> > 				flags2 |= FIEMAP_EXTENT_UNWRITTEN;
> > 
> > 			if (p.crc.compression_type) {
> > -				flags2 |= FIEMAP_EXTENT_ENCODED;
> > +				flags2 |= FIEMAP_EXTENT_DATA_COMPRESSED;
> 
> (defect) This should *also* set FIEMAP_EXTENT_ENCODED in this case,
> along with FIEMAP_EXTENT_DATA_COMPRESSED.  Both for compatibility with
> older code that doesn't understand FIEMAP_EXTENT_DATA_COMPRESSED, and
> because the data still cannot be read directly from the volume when it
> is not mounted.
> 
> Probably Kent should chime in here with what needs to be done to set
> the phys_len properly for bcachefs, or leave this patch out of your
> series and let him submit it directly.  With proposed wrapper in the
> first patch of the series there isn't a hard requirement to change
> all of the filesystems in one shot.

You get phys len from crc.compressed_size - that's always guaranteed,
even if it's not compressed


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
