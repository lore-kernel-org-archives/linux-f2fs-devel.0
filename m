Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC31EFCE39
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wJ4AiLK+hcK4CyZSyneOjKleN/42GuImdyh4kwIfx1g=; b=CF2OO+sdR9O0h/U/QglokNzhol
	xlO1hr1HR9dpK8WF+0T18/avs8KdsRcren4IRdi9SqmlEIyyCogAILCpIsOTmVUpl5A1TCrbH4iYL
	+ium7OUGzt6ZC2k3chwwtjJ34L1pGZdiLkZoKQq5vNe9wtEdLNcu6IHKl9pabWE6qhFk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxrWT-0005bM-V4;
	Wed, 04 Mar 2026 19:04:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <agruenba@redhat.com>) id 1vxrWS-0005b9-On
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=content-type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u7S3JSUw0L6B/lSDSpa518AgIIh6Ud2RJzojY8j4acU=; b=AQ4eSCdQQdH1ZOU487cW2EbDb6
 wqIF5AlMMwfOawEztzp0ufEcjr2Ei//WZGgzqU6Y3nykWmhazVQYkfQB3qw9zgzzDJdmXApvVOlAe
 yShQt0s8Pm93870RYdMJaHx4AeqENK1/sAa3oa7MUUpfRMDcbOfj5F8JGOMwtojFtROw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=content-type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u7S3JSUw0L6B/lSDSpa518AgIIh6Ud2RJzojY8j4acU=; b=J
 7I6xDXuLkzdeov8UhivTlIKk4z4yD4iV6eIhxMDgMvH8hP799UT2qcn4mCpKo+jAAFlPAAOXSPrCg
 QKyhmlkqB58tvR/nmeootRywUaZZvA0oNCcRytOi7b0U9mXMCcW1YFOrU8myLjrGVUZT5ERLOoOV2
 S3SoUgj/v63dvg9Q=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxrWT-0001Vf-5o for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 19:04:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772651074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u7S3JSUw0L6B/lSDSpa518AgIIh6Ud2RJzojY8j4acU=;
 b=b4N729OlFZoc9R4WBm+T/Hy/g7KrQAAD1uBILdVW+d7ltGNUEMlLN29xdWLSdK0XIEGQUM
 g7R1iQ5uh04Pa7wfMoogXhmCqCmdEkGUPd9aj6max9pTDF0vN9iGYI6C2+J9yOj9tQSVIQ
 0xeQqeG3goQfoc/RM0Uv8fioP9qxS60=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-nJzCNDAMOC263_7eoJTryw-1; Wed,
 04 Mar 2026 14:04:30 -0500
X-MC-Unique: nJzCNDAMOC263_7eoJTryw-1
X-Mimecast-MFC-AGG-ID: nJzCNDAMOC263_7eoJTryw_1772651069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABAB61956096; Wed,  4 Mar 2026 19:04:28 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 298AB18002A6; Wed,  4 Mar 2026 19:04:25 +0000 (UTC)
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  4 Mar 2026 20:04:05 +0100
Message-ID: <20260304190424.291743-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: -Ek9ARVfytzBp0GY8GGTDl0uuvsjZ3vWzpbS8OJIV7Y_1772651069
X-Mimecast-Originator: redhat.com
X-Headers-End: 1vxrWT-0001Vf-5o
Subject: [f2fs-dev] [PATCH 0/4] simple bio cleanups
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
From: Andreas Gruenbacher via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: dm-devel@lists.linux.dev, Andreas Gruenbacher <agruenba@redhat.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Jens,

here are some simple bio related cleanups.  Any thoughts?  Can those go
in via your tree?

Thanks,
Andreas

Andreas Gruenbacher (4):
  block: consecutive blk_status_t error codes
  block: get rid of blk_status_to_{errno,str} inconsistency
  bio: rename bio_chain arguments
  bio: use bio_io_error more often

 block/bio.c                   | 22 +++++++++++-----------
 block/blk-core.c              |  5 +----
 block/fops.c                  |  3 +--
 drivers/block/drbd/drbd_int.h |  3 +--
 drivers/md/bcache/bcache.h    |  3 +--
 drivers/md/bcache/request.c   |  6 ++----
 drivers/md/dm-mpath.c         |  3 +--
 drivers/md/dm-writecache.c    |  3 +--
 fs/f2fs/segment.c             |  3 +--
 include/linux/blk_types.h     |  2 +-
 10 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
