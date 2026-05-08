Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7979ECD342F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 May 2026 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHBhg4klM0odKyh5bU6hWIaB/M0+NPyEad3WL70cWto=; b=C0coOfIU9RxIwtyvCOvDRiI1Ef
	ftvGQhwn21AOCEchUhRmGfrZP7qhova2EIbC0bAnA5fbfF38aSoe6i4I+sTxUTZ4PBmShtCbChpbF
	rqXd85Tcc8ty8pJfFJO/o2yQBjinPiiuL4WZuZFTu8grJHdr9+6BantdwwZaI+h5U2GY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLQcp-0006Tj-Ly;
	Fri, 08 May 2026 19:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wLQcn-0006Tc-TN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 May 2026 19:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wLEiuCDgKaiCsg2c4vVq7SFZlABowI3dQgNOVIyFu9I=; b=aIoFZuL+TiZZnH1vefC/xFWyik
 e704bX8xIi6aA2L5QH1FHfHeAavpKoc9XFncfwerfAPSqIvek80kl1fpFMrBx4kMFE/AAdmnuPG2N
 g9Mc7gIKT4X5ilgHG14kMCGy55oyVL6eQJQNPVpRCWeTPOpEPE1tvQ1Nch2gMo40kGv4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wLEiuCDgKaiCsg2c4vVq7SFZlABowI3dQgNOVIyFu9I=; b=G2ovGlJe5qcOQbn0Z1uW3IANIR
 HihO6+fgKaMQaw62riJXngGUdsmquEF0QU+3R7jYYO6SpI+noKTWoMddwf1Fc1sY+pcnkKGGvbRUE
 71Z3Vb2CJKnPKY7erogenRoy5yvKLhhC9kypX9/AuCd3XTnZEyt3blX+MXohqp/nLhL4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLQck-0006IF-02 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 May 2026 19:12:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 69CDB60181
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  8 May 2026 19:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D7BC2BCC9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  8 May 2026 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778267543;
 bh=azt9SoyouQmSjBFhtn1rDIK+kX0TqDuz+JYgsjKNl/8=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=ZZHA4J3B8Ba+VmVCajW3W1ZfEtI+54Xn8kH/kOytHdqTXKcayz/mCmW+tYq0Kje0t
 TlFgIaCc3Yx5puYv38VitdpeYgAIIyINc/JDq/BYyxu07sLafvRDzbxgck0SkaAe3g
 11n4JcSecX5JO/EOGvgPyutzIHyYFRVViF5+vAZAJ6FB2ruV5e1/r8ykDoZue2+Spb
 1iDGZ7neEPzdSBthvE8PrwIUPyxvVe/oxi69Jh8q6RKZGM/Dix8qNydZmpFb0mBeuX
 jRddl42rZHz/fhGilxhj1VrLf2/cKu6kG5qVTtc/p0tJKNrXF0lOUtjFRnZ0b2lC4x
 qQUdlhKtLiSqA==
Date: Fri, 8 May 2026 19:12:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
Message-ID: <af41ldQi2PoFFaTH@google.com>
References: <20260409134630.3693274-1-jaegeuk@kernel.org>
 <20260409134630.3693274-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260409134630.3693274-2-jaegeuk@kernel.org>
X-Headers-End: 1wLQck-0006IF-02
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs_io: use O_RDONLY for fadvise
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We don't need O_RDWR for fadvise.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 8b9f9ef22eef..94e61b850923 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -474,7 +474,7 @@ static void do_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	fd = xopen(argv[4], O_RDWR, 0);
+	fd = xopen(argv[4], O_RDONLY, 0);
 
 	if (!strcmp(argv[1], "willneed")) {
 		advice = POSIX_FADV_WILLNEED;
-- 
2.54.0.563.g4f69b47b94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
