Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D9CD5BBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYRI3wJhn9Z9aUWkfWoJDHXcZAr5Q8Aix61yFAgbbqY=; b=Phvan6NR5yWbtSuDQ5SzMHXUO4
	M3B3WtM898XlINub3lqzMXsdT0t7G0bTyxrwo3F+F+KdjgScA4kkV3UPioOykJdj2/3G04C5geRRf
	7T4/f06VP2tNFzJ6a6YA7YHdz0rZcGXM6Rb+K3P6gDB1eUB2UIUndeRsecHL+7QVGYAc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRPTr-0000lP-D9;
	Mon, 25 May 2026 07:12:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wRPTp-0000lI-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqcxhYP71Y45aA5yA9zJWnZB6u8t86CEsBFptEY8fj0=; b=HRgnZPgkhRowMRYtiYvhY+22aX
 Q63kWRwCL1u9ifi7u/my0PXZy7mr3uRs1e/oPelK+Hf8Wa5GBu1NEkM7Tg4KJsdLmzLTufYp1CtLx
 6o/D/uhJ/jmX8P7D7SlCbB5lNVEvhkt/cVQmcOgqc657PGZrNRpBsLjzNwcrmHeA2TZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xqcxhYP71Y45aA5yA9zJWnZB6u8t86CEsBFptEY8fj0=; b=JQ0cD+EFXasO4GN/MwD1lJN5AG
 XCPD1M6F0MD5b+i4xaGxzP0fItvMvk2EqmFjI91RtsLNYHdmgbU+7HNzrmRZcu4D1R/dcvK/yMkeO
 tM3MEOoxBSxLy6sY9fxiUIYbuCeCK5dP8AbdENLQ5FUIMRAGjqE3KSse4B2KCDDay66M=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRPTm-0008Vw-5E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xqcxhYP71Y45aA5yA9zJWnZB6u8t86CEsBFptEY8fj0=; b=1A9EkQLrKBcFUFwj6aS6K6lXCJ
 ASmNZPmU+odZG3FRd6nhizJsMn238rFOAmrMbyf6mh/Zd7gVSeIrbyChFhXyTGI+ljzOG1XhfnnE+
 bqgfAztY/aWKqN/VYg8zggDZtoLbjAyK1fpTU5k8toSkjDaasnhmyKrDvBdtP0jbgLJsdHNQ3NWUG
 KYZ0Yenu2dOFGi2LI8GOdhijZCjLuDa9N8c9aCPlf/jvwKlX8O4AUunr3xL6tbDeDsLnUa9qthr9G
 cyxpnxPXKUlFM8ZQ6VorUqmo/I1fOy8MskuKMcVTq26JZTM6zL86ZXYFl/jx/b9tP99f7BEAPm33M
 dbEmNyGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRPTc-0000000GVCw-0Mn5;
 Mon, 25 May 2026 07:11:52 +0000
Date: Mon, 25 May 2026 00:11:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <asj@kernel.org>
Message-ID: <ahP2OOXmwsM87j9D@infradead.org>
References: <cover.1779367627.git.asj@kernel.org>
 <bfc0c92a33bf5a129dad4c3e4c76973e7a6cec74.1779367627.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bfc0c92a33bf5a129dad4c3e4c76973e7a6cec74.1779367627.git.asj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wRPTm-0008Vw-5E
Subject: Re: [f2fs-dev] [PATCH v5 04/10] fstests: verify fanotify isolation
 on cloned filesystems
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
Cc: hch@infradead.org, zlang@redhat.com, amir73il@gmail.com,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"

Same comment about adding new common bits outside of test cases applies,
but why use both inotify and fsnotify?

> +[[ "$fsid1" == "$fsid2" ]] && \
> +	_notrun "Require clone filesystem with unique f_fsid"

Please add a comment why this happens.  I also have to say I find
the if syntax easier to follow then && with a line continuation.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
