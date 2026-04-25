Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E86FF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Apr 2026 01:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sIMgX3T1KOL2DuoB4IPj9CeZ8J4jkoQs+ySP8yDvuJI=; b=LoJ2cEcMFKgCLgD6Oi1REnYLud
	i+7VEO7d7eZtnhhgovLjznYpXJjakRHC800SKDxoBaHVz4V6SWyKEOQjrcwycwalnaSFtM8FWLljZ
	KlvWOE/q9I+V42Fk29mzx2Jp+NruaT5gz88sKw5AgAR2bpTuVuHDNFE/hte59wooXkXg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wGSDd-0007NW-8T;
	Sat, 25 Apr 2026 01:54:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wGSDb-0007NC-VS
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:54:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Qtgq0lrKzHBIMETyssvAoIWXJqi8PERbbVTHZhGAx8=; b=iO8DO015lCmBHXi9u3xIdvWd9f
 /bqak6Jwb3ylcamouYJVF4nBcuYW/dGmFCioHEdI2q39V7pVReZ1dzf9swA986sUQiYRIGRW1PIl9
 cmC5/u4zkpUcSU0k1RV2DWk+jmWNicTdGghKnwjC2+A5FxnzxwsNXTOH1QhThoBeuk8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Qtgq0lrKzHBIMETyssvAoIWXJqi8PERbbVTHZhGAx8=; b=IFGn1fYUCUkaFq5KmloEDtdVOr
 sikXBgTP41rjO/2IB6WCXqABgwJtuwnIJCxyAoNaNtT4IcKC1M+Omcgh2P8KUQQDcfLUN3iBVOL1d
 Cx07f8VbPyugeEg5u3yvjqQfcgWQ+7cjfTnUqZu+1Y9UO36LGkvk4Lmfdv+LRtCvY8cM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wGSDc-00032w-6C for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Apr 2026 01:54:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D2C3242A53;
 Sat, 25 Apr 2026 01:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C400C2BCB2;
 Sat, 25 Apr 2026 01:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777082038;
 bh=7qcGCalbO8KkpsIrewxDQbW3F+/q9MR1MUul4uvB6WI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qi95WQXpNDyjFy0LmxKlrTgZYQSG6IZVyOSGR3pwU5+X2dq0sJrZu1yDrdNkrP7qB
 qg+uy3te+g0wBp6ZJbxfv1lETETLS9en9LpqJR3FvgNEbp9H4XTYmJEPoMp0dR46tq
 lnEnRr0ol+e4oEFKkzpoLJSplrPxMgL0oMqjZ0qp2C9kh8dvh1+L4h2gJGWtu/HNx0
 3MS87r0r/0080EUT3t/YYala546EMl1AP+CjzU6IER3AQ6O+k5SKsfOBYjn2DQu2aV
 5x7uRM+Puj9HbmNMgxp6ePEp/XUldAqcial4d4QygCZFtZOyE+MrxQWd4wtn8EtFbe
 uS0veZmNzuWxQ==
Date: Fri, 24 Apr 2026 21:53:16 -0400
MIME-Version: 1.0
Message-Id: <20260424-case-sensitivity-v11-14-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Gb++2WXxq7tymC3lSBQQTwIgZZJUrL12YzUU9YIeoRg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6RFnJh5RPlhzv8zOFhfy+P+Bn3NqH2/9JE5
 hDuPI1TwTKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekQAKCRAzarMzb2Z/
 lw2REACbr6lCxWkqB+jzxg/IBfXv10fHbhPzMCvQlZWb+dbrracqFwJuhhC4/6M9Pc73JmJ1WOl
 OCdBLrEvpPKPy898FKaA6nLBZ46ziYNeqqDSHTuqIqPRcIjGwHL0izSHHMdO33POOb+BfEd9CSe
 pnnpsnPyqYu8vlwBv7gkReIWcmGankd0OQUO2oTwiMD0+WRaFi9jfWXIzq5WQOdEtJ4Xo+GIrIm
 D3fMAPC4n2QLSl1+G+Jatxv5D1iUDpToG3lcXHjHm3U+k+mB6P5jkV6Ol9W3F5izpMq6+iaCnhe
 1lq2f1fYB8Jjo1vasu6QJNkqZ2xfjbK0qKCz4pC1KFJEcwwBVUq4/vrK46uDY3JjDYNHof7b7tK
 +xSMFRgEdjWiaOWyJqZR3jmtruIYnAk6pkokurwbNrQs+EaUUWHS2XEqpvay+pJ9wDg/3PR2TQT
 07eR1o6ctS8a1O1KksJMqN97jRA2nr1VsilkcXKNTVvBfJt2Bn79yNGQtjbGnYCUbaSitdi1Y1n
 OZsUgGaT38ixBRL9MWX42O8Eg4mLPYwz0jOW4jTPWNEAHEwXn0Q1LuB3HtHSPLI/L1oGJf8Z+mn
 +c08lbwUV1Gb1Ve1dcq6zQhaj5EnGgmy8eWpnFZJfr2sv03K3T3nZTHWUgtdQ1Wk91fh7hnYdCY
 Vn18aYwYyULhRzg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wGSDc-00032w-6C
Subject: [f2fs-dev] [PATCH v11 14/15] nfsd: Implement NFSv4
 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

NFSD currently provides NFSv4 clients with hard-coded responses
indicating all exported filesystems are case-sensitive and
case-preserving. This is incorrect for case-insensitive filesystems
and ext4 directories with casefold enabled.

Query the underlying filesystem's actual case sensitivity via
nfsd_get_case_info() and return accurate values to clients. This
supports per-directory settings for filesystems that allow mixing
case-sensitive and case-insensitive directories within an export.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..68b23863dab1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3158,6 +3158,8 @@ struct nfsd4_fattr_args {
 	u32			rdattr_err;
 	bool			contextsupport;
 	bool			ignore_crossmnt;
+	bool			case_insensitive;
+	bool			case_preserving;
 };
 
 typedef __be32(*nfsd4_enc_attr)(struct xdr_stream *xdr,
@@ -3356,6 +3358,33 @@ static __be32 nfsd4_encode_fattr4_acl(struct xdr_stream *xdr,
 	return nfs_ok;
 }
 
+static __be32 nfsd4_encode_fattr4_case_insensitive(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_insensitive);
+}
+
+static __be32 nfsd4_encode_fattr4_case_preserving(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	return nfsd4_encode_bool(xdr, args->case_preserving);
+}
+
+static __be32 nfsd4_encode_fattr4_homogeneous(struct xdr_stream *xdr,
+					const struct nfsd4_fattr_args *args)
+{
+	/*
+	 * Filesystems with a Unicode encoding loaded (e.g. ext4, f2fs
+	 * with the casefold feature) expose case folding as a
+	 * per-directory attribute, so the per-file-system
+	 * case_insensitive and case_preserving values can legitimately
+	 * differ across objects that share the same fsid.  Report
+	 * FATTR4_HOMOGENEOUS = FALSE on such filesystems to keep that
+	 * variation consistent with RFC 8881 Section 5.8.2.16.
+	 */
+	return nfsd4_encode_bool(xdr, !sb_has_encoding(args->dentry->d_sb));
+}
+
 static __be32 nfsd4_encode_fattr4_filehandle(struct xdr_stream *xdr,
 					     const struct nfsd4_fattr_args *args)
 {
@@ -3748,8 +3777,8 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_ACLSUPPORT]		= nfsd4_encode_fattr4_aclsupport,
 	[FATTR4_ARCHIVE]		= nfsd4_encode_fattr4__noop,
 	[FATTR4_CANSETTIME]		= nfsd4_encode_fattr4__true,
-	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4__false,
-	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4__true,
+	[FATTR4_CASE_INSENSITIVE]	= nfsd4_encode_fattr4_case_insensitive,
+	[FATTR4_CASE_PRESERVING]	= nfsd4_encode_fattr4_case_preserving,
 	[FATTR4_CHOWN_RESTRICTED]	= nfsd4_encode_fattr4__true,
 	[FATTR4_FILEHANDLE]		= nfsd4_encode_fattr4_filehandle,
 	[FATTR4_FILEID]			= nfsd4_encode_fattr4_fileid,
@@ -3758,7 +3787,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode_ops[] = {
 	[FATTR4_FILES_TOTAL]		= nfsd4_encode_fattr4_files_total,
 	[FATTR4_FS_LOCATIONS]		= nfsd4_encode_fattr4_fs_locations,
 	[FATTR4_HIDDEN]			= nfsd4_encode_fattr4__noop,
-	[FATTR4_HOMOGENEOUS]		= nfsd4_encode_fattr4__true,
+	[FATTR4_HOMOGENEOUS]		= nfsd4_encode_fattr4_homogeneous,
 	[FATTR4_MAXFILESIZE]		= nfsd4_encode_fattr4_maxfilesize,
 	[FATTR4_MAXLINK]		= nfsd4_encode_fattr4_maxlink,
 	[FATTR4_MAXNAME]		= nfsd4_encode_fattr4_maxname,
@@ -3968,6 +3997,26 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		struct dentry *cd = dentry;
+
+		/*
+		 * On casefold-capable file systems the flag lives
+		 * on the directory, not on its entries. For a
+		 * non-directory object, name-comparison semantics
+		 * come from its parent. A directory (including the
+		 * export root, whose parent is outside the export)
+		 * is queried as-is so its own contents' lookup
+		 * behaviour is reported.
+		 */
+		if (!d_is_dir(dentry))
+			cd = dentry->d_parent;
+		status = nfsd_get_case_info(cd, &args.case_insensitive,
+					    &args.case_preserving);
+		if (status != nfs_ok)
+			goto out;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
