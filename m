Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C42CD5BC0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 07:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WlsCuUrH/RVXcCLD9ipOiR6GeFrz5KmOE8Sn4r2xLA=; b=DmuXj50hnlCZiK4yUHfqG1RavS
	rxTwCPAOBEW9sq6Rnzk6muADi6IOBfm9XkuiIyrdyC+ivOXgO8AhbZnBg3pHjmLL7TPxDBo8y3RE4
	xAxkvnz3dJAPGQfWVxPMODVl+khr/GUaCUns3FfCsGzA6IPt8FZpq0kRlEWkwf9jPyPA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRPV0-0000rs-Ic;
	Mon, 25 May 2026 07:13:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wRPUz-0000rm-W7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J+0lw6yfGWbYib4LjYGQU8KARgYeOuTXyg6uoz1irQ0=; b=RmRYv/g9BIjFcim9etZ5V9dN8o
 44oyhOyElvsuvWiT8xVBUYj0QruiRu1Vq4Hgwt+epBICH9KUCM0lMyLlbxRaEauHdfJvyYNYG77xq
 SRTK2MO4zS/Ufs4gGrYo7qRotepyEGViBmHmcCAd6a7kpKlooWkvng4K8XujMufhvoNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J+0lw6yfGWbYib4LjYGQU8KARgYeOuTXyg6uoz1irQ0=; b=b6qP5iKWf4FSrR22dUtyhRhwpz
 Bp6/DcbVuvvYlHDfEk4vHidIxt/XBEqlXcYhGChAw5KDUFq5xxYogwYxITP2/Qnws/uG3HZroh56K
 9N9GNre/BWNpcnt1YOCVyQ2qFQLFcQTNIwGItqn3mU7FAOoaWq/uN59bZzp5XtBD2lHQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRPUx-0000ER-LB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=J+0lw6yfGWbYib4LjYGQU8KARgYeOuTXyg6uoz1irQ0=; b=rja6ZMgwmYky+Mgp3cOdXeyx1e
 BWeT3Dll/ki7OhlFpBcbMZUinH5ZAdARDxNfcaYorr5hdha1ZmpqsjV2AZtvooTbwix9xU+Qt1cGX
 f20cVi1CL6K1T2wq5wvN+v+mmk5jxvZTOrU3TGNB8a0AmHwJY1+iDiPIViCXsd/YqYDGlXj/4mQAa
 iNYS/iNzCk+jDDD4E9ybBwQucdVLe0ZXpXJ6HX14XmesUwdgFqPSrlBuCQGNlDceCsRox81VQ8VVD
 FKFY/ikLOxUPiZxa9Gjm3AiiXRkvQcHewhCnhQllKIyVN9ieSKgzJ6bUKEO5DQkebUtTspjL2i4jY
 iPAyGYew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRPUs-0000000GVL4-446x;
 Mon, 25 May 2026 07:13:10 +0000
Date: Mon, 25 May 2026 00:13:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <asj@kernel.org>
Message-ID: <ahP2hjv9zl_WL1kg@infradead.org>
References: <cover.1779367627.git.asj@kernel.org>
 <a24645463979d0550e0010030995b0ed609215c1.1779367627.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a24645463979d0550e0010030995b0ed609215c1.1779367627.git.asj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wRPUx-0000ER-LB
Subject: Re: [f2fs-dev] [PATCH v5 05/10] fstests: verify f_fsid for cloned
 filesystems
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
Cc: zlang@redhat.com, amir73il@gmail.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 21, 2026 at 08:54:55PM +0800, Anand Jain wrote:
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"

Seems like these are stuck on the btrfs list.  Any progress on that?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
