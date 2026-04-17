Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44603F8E4B7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGW58iw/5fiVP0wiotKIvsrLG7ShXb/BNHrQmdn7Z04=; b=R+3BW1KJ/jXTdOqZMGhWOrf+Vc
	D7DQtVwT3J+6N59mDIxHzTXmMuNeLFzvi6BI05y7CqyF+RRrztVjC4LHMDOF32tXG/+gv6km8WKPA
	ZRnfAcSibhc9MVaC5qXqYUc8CADgvuYVuEV2E5vVdNnQ+3VdlnGdCphwMgQnH4fLzGY4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDdqs-0003EB-0y;
	Fri, 17 Apr 2026 07:42:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b5300baf1831a8dea0e9+8272+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wDdqp-0003E0-G3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 07:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0TEJQ5i1u+hzWw0Z9naqmCaEfyBLwUowXxtFdU7bi1M=; b=lYQNc74r2QNp+B+pruP2GvhLUo
 QXIPWhEaBodm9xVfVv4y1JapN3i6otXyk/jgXNawagTLCN6Y4BMgRqiREy5eznx+vHmMqJOGKXpmj
 jF/Q0HJPlUrPghvVaUrv5Let5HhZhDLBHdcY1WVepQH6NC0w2cSfhdUTxoCjA+ynvuxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0TEJQ5i1u+hzWw0Z9naqmCaEfyBLwUowXxtFdU7bi1M=; b=R3PJtuORxfFGsEsj8vK0X2kswA
 iwcFkXd/4l1/qEBBvGcsEdKi4aqh2iO551vhTcJtXMx0ulY+N/DXhyN3Y74opIHb/D/YdrH3nP6Lc
 xZS9uR4iHU6tTzyeBBL0TAqufeAj0RVlO0UXKNU4JDvtnEz9ri8wNfgbwYeu3zVRLU/w=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDdqn-00014L-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 07:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0TEJQ5i1u+hzWw0Z9naqmCaEfyBLwUowXxtFdU7bi1M=; b=HZwaUTu+SCANS4vzNyB+XxG+ij
 EH3LiXNthGj5uxBiwzM61T5wM3OHcZBbHR4RQTKvpa3TyRH0r9/gUi10P7m8eSmKsM1IVXALrmJGS
 /j36olZd/golaScP3EDrrqdg7LS66BxRKITYvwSJVGTsZs4k764pqvLf1DR/fYISF9u4+b8e7pM3b
 GoPGFRaQ1E//KIHNtMAkd0Cpe26dKvpBVsNNdds2i9bznFb2jDuBnAj1QyP/BQKz93rFX5QxBNrVI
 UfY+h27HEAbkT+2tuFy/cHw9lKje6M84sHmxyvmHbj8wDDNgvNNpKlbph6dhGdViCIN8Bi4F3HPbL
 +B4oKM0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1wDdqg-00000003c5L-3xEP;
 Fri, 17 Apr 2026 07:42:46 +0000
Date: Fri, 17 Apr 2026 00:42:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
 Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com,
 wqu@suse.com, Jan Kara <jack@suse.cz>
Message-ID: <aeHkdon2GH8UUkE4@infradead.org>
References: <20260410131821.991005-1-jprusakowski@google.com>
 <ad3zThMKaWZ65XE2@infradead.org> <aeER8AIJZecuTLIc@zlang-mailbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aeER8AIJZecuTLIc@zlang-mailbox>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wDdqn-00014L-W4
Subject: Re: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal
 filesystem
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 17, 2026 at 12:47:09AM +0800, Zorro Lang wrote:
> > > Therefore, F2FS does not need to write to the device to recover, and
> > > successfully mounts on the read-only block device. Thus, it should be
> > > treated as nojournal in this case.
> > 
> > This looks ok, but I always wonder if we want an opt-in for this
> > "journaling" behavior and/or define it clear in common/.
> 
> _has_traditional_journal ? _has_journal_replay ? :-D

Good question.  We already have _has_metadata_journaling, which is
used in this test and in _require_metadata_journaling.  Unfortunately
no one has bother to describe what behavior it is supposed to guard.

From looking at the _require_metadata_journaling users, it really seems
to be about providing file system consistency after crash.  So maybe
_has_metadata_journaling, should be renamed to this effect?

Now in generic/050 the check patched here is used to select the golden
output.  When I wrote the test originally (I can't even remember that),
it was a XFS-specific test, and Jan then later tested it to add this
_has_metadata_journaling check, which also needed further btrfs
workarounds.  AFAICS it is all about failing the mount if log recovery
is required, but the underlying block device is read-only.  So maybe
name it after that?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
