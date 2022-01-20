Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C536C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jan 2022 08:27:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nASnW-0008Mc-Mw; Thu, 20 Jan 2022 08:27:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+0328028a7a74e2859a11+6724+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nASnT-0008MK-AF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 08:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvoGguWE8KfBM4538M3l0btmQ9N+hOwabmMgVLC+gno=; b=Ry5TVuph8O7TNWb6CnfO/0xlrk
 lzHTmQJWnNv7WeEf7tp58fb+80b7d25Ysksgwl7LV1Tnxq0XO3YQv89kNSNWbKY5FhbTOsnNCH8ra
 1ROzf9ur93yXLTa4leR2iS54oyhPME8UT1GLTSodlrK5ezNGv+eEg67VkYwMES8xdp+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NvoGguWE8KfBM4538M3l0btmQ9N+hOwabmMgVLC+gno=; b=TALqBSD1BArdKvaIu/Ah5W+huk
 VV+JUX9AqmZFLis3TTaHrlL3BhF0AsX4TfM71LDARphZGK3PMjOjWyPoHuL0DPVoVY3gqT1vSYOaG
 GchZXLdSAJrDSQz5lKDvPFqAMEw9APvYpoSs2mOKa+hChEYSfC5mGdbB+KV9p8Pjdo2Y=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nASnQ-004f4g-PU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 08:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NvoGguWE8KfBM4538M3l0btmQ9N+hOwabmMgVLC+gno=; b=vdL9/LCIsKA/ZuPkjYTLiufeyy
 zkM0HgffALaitBeO6Q7A1SRP9lTgJJSzQBGPKnRo+MyDuoRqf6BUmaesQaGvMMJ0cUvp8sbX1yXKf
 DXl+8z3bRs/4eZIyI2/XlUmYAYH/0l31eTNUlpxoUrYc1QFdwUNDchBSQ39rBGb3TRQUJudHq/t1d
 Afz8DHBzwEVQh/0HzT+NB9VpbRvVc0S6nnnwnAv+IKuCoH6AVRWNIRJNZJ8X8wBP9BDjqCOiggDGM
 UcRgAyrvA7i2VrJ/6zOPchbVoi22WiVX+zueyPxLhPr3qOeEtqo7o/tFztKAAeqcRprYEPSppKH55
 S7BOaMww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nASnJ-009kk9-OV; Thu, 20 Jan 2022 08:27:45 +0000
Date: Thu, 20 Jan 2022 00:27:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YekdAa4fCKw7VY3J@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220120071215.123274-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nASnQ-004f4g-PU
Subject: Re: [f2fs-dev] [PATCH v10 1/5] fscrypt: add functions for direct
 I/O support
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
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Satya Tangirala <satyat@google.com>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +/**
> + * fscrypt_dio_unsupported() - check whether a DIO (direct I/O) request is
> + *			       unsupported due to encryption constraints
> + * @iocb: the file and position the I/O is targeting
> + * @iter: the I/O data segment(s)
> + *
> + * Return: true if DIO is unsupported
> + */
> +bool fscrypt_dio_unsupported(struct kiocb *iocb, struct iov_iter *iter)

I always find non-negated functions easier to follow, i.e. turn this
into fscrypt_dio_supported().

> +	/*
> +	 * Since the granularity of encryption is filesystem blocks, the file
> +	 * position and total I/O length must be aligned to the filesystem block
> +	 * size -- not just to the block device's logical block size as is
> +	 * traditionally the case for DIO on many filesystems (not including
> +	 * f2fs, which only allows filesystem block aligned DIO anyway).

I would not really mention a specific file system here.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
