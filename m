Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94048CD13DA
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7l9B1FwE2G/Te5gv/j2CQbgU7wjWG+EJTmH73kLvvo=; b=gNCrLscR2WcgHCIudj1b317mCv
	y6GCEM6xo2/QhalXwXv1lR9AAiOmaTperla8f/Q64mKLjaCXAqpKaA4fJ2yCVYEptmw4OiOOIubXk
	1RIMVqMdLSaf0oexTCOKiPDgfhozDn2ccp675CRuZlxY31OxJ30tzgXj71FVhYkdNgPQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBFb-0002Ju-FI;
	Sat, 02 May 2026 14:23:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBFE-0002G5-Bi
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:23:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H6LrVNOAsn52vRXmQTdnx0gnJYR94bVsn7e/sI+uXsc=; b=mLgTpKkYnlpMsGrrpU5H2Kpgyy
 JQNaoQK4qGQE5TgBf9KmiRkAeWRfvO695nVcPkyHnk3YEZhkEdWKLig42I4MmTqNPwKkEE/ui38Hj
 nsobe8ar5rsFjhsRcz2Fs8G6vMrn8aj/c5NYH7hI4BP9DbhMsTrMOXl2fzAfCSnOIxM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H6LrVNOAsn52vRXmQTdnx0gnJYR94bVsn7e/sI+uXsc=; b=mSAufPhePh/SzOlpbiXjbYp/v6
 6dwJ+czLJT7acm6qmFpun+sePHF+k4cOKNyS8z7GFOhtsZfkQwQKFvNABtfMnHhNT/lEMW3J+Hdr4
 qP1/dacSFmxB23HrzGLwusrxDMwSJ21cSemP4/mTYfIM/uW8ZR6IS1SVaMgJ6lIeiDSI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBF0-0000xJ-PH for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D0C043499;
 Sat,  2 May 2026 14:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BBDC2BCC4;
 Sat,  2 May 2026 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731756;
 bh=IBYLppDmEpk49AW+aDaK+jyoS+KenxvVpd0xkXYb9e4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rywUvWSA3KU3kEM5YOrF4I92KWz+dtWkTT8uoGD9VBQtax69DobSaFypVCqYj1aWm
 q0RvEnE4pakgtcGecOU3GyFbRQONukv06+5evNASwdKplvek+qRIW0iHlCxKC6qCaT
 Ck8nik9bwdptwSMqQaqiUBozSQOuYujV2llca98tNPEQdDhJIWyenOiDzPOzNl37cN
 /E238E6IxpZ2JqOwZ77kiVDE+VrxB8HTsiaXpTkXrAmjBRJ7i0XIBjm1s/tA6X1ikR
 E44bksEOKBURrMDtY/VH4SR5MtShX63LW/4sJGBD4ds63MM5Ne0aCzv6rkyynC9HSc
 1f7g1N/oSOu5g==
Date: Sat, 02 May 2026 10:20:59 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-14-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4936;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ezCClrtcetCYnq60ZMthhQBIKalbwZM7UJGTvsJx60Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRZHXDWrBOKBPiYd9/A/2qNYBxWjYNc1mUa
 Mba+1U/o6KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 l+pHD/9szCzlJ7xx0AGJZxYiKgNGx1GH4rZVoB9AGHCULctRjTS8Sr4J1/C26ripNZiaFeAruqe
 LRq0b1NedgTGLdDZTJZBWn1H3uMrSgVmicsLzCeWICFj3A/idmRcKKuhppN4Dmv1BRRoi+5QQEC
 +RIOJI1FwsXEcwMsh5h5KUz5vmqhybBVsL74+Qe3RvP8UEVC7bcmdJAjmULRjMS5By4nt4LfvyP
 CXib4VMqDBHdIX3JMUfFsQPzIOMRQGQLFPj1A5JE8UXlTbZBo0M2B2mPerQ3p7BrN6oBgkL1uba
 WkuyvGK7RLu9wASejqw9shamCX94tmP4cKSsASn4HTVPkq4Qb57V31hw0amtYul/gILYiQT6Ufp
 4TBAiBeWBWKxK2KvSL+nFV0KfiNlvrgwA4u46Bm1KVsPgDx6EqEwcoj+qU/yFBwokxQIXAqg0Gy
 hHMl3cxIinx69VXAfXl5Rz24kCYb6QVkavxWT0uFPqGXL72vJKG82Bs7eCHX1d5EFN56wL3HR5U
 YlUi9sWmqjYOq1Kw4a0SgQb/TPJRKhCE5GFNGR5LT7YwbAAc3O7QK4kOKxtDbsuSDarbBR45EVT
 3wELlC8ube+lyksLB+oU0QrbEayaPuxvUeXhC1p27b2YbwlyXiziuELrpS68z4c5N3JGc582u3N
 Ix2Tqk2gVUEX/+A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBF0-0000xJ-PH
Subject: [f2fs-dev] [PATCH v13 14/15] nfsd: Implement NFSv4
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

The helper queries the parent dentry for non-directory filehandles
because case-folding is a per-directory property. That resolution
has the same corner cases here as for NFSv3 PATHCONF: single-file
exports query an unexported parent, disconnected dentries report
defaults until reconnected, and hardlinked files track whichever
alias the dcache currently holds.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2a0946c630e1..d77304692e11 100644
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
+	 * Casefold-capable filesystems (e.g. ext4 or f2fs with the
+	 * casefold feature) attach a Unicode encoding at mount time
+	 * but apply case folding per directory.  The per-file-system
+	 * case_insensitive and case_preserving values can therefore
+	 * legitimately differ across objects that share the same fsid.
+	 * Report FATTR4_HOMOGENEOUS = FALSE on such filesystems to
+	 * keep that variation consistent with RFC 8881 Section 5.8.2.16.
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
@@ -3968,6 +3997,23 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 		args.fhp = tempfh;
 	} else
 		args.fhp = fhp;
+	if (attrmask[0] & (FATTR4_WORD0_CASE_INSENSITIVE |
+			   FATTR4_WORD0_CASE_PRESERVING)) {
+		err = nfsd_get_case_info(dentry, &args.case_insensitive,
+					 &args.case_preserving);
+		/*
+		 * SUPPORTED_ATTRS unconditionally advertises both
+		 * bits, and the Linux client treats an absent
+		 * CASE_PRESERVING in a GETATTR reply as false. When
+		 * the filesystem does not expose case state,
+		 * nfsd_get_case_info() fills POSIX defaults
+		 * (case-sensitive, case-preserving) and returns
+		 * -EOPNOTSUPP; encode those defaults so the reply
+		 * agrees with what the server claims to support.
+		 */
+		if (err && err != -EOPNOTSUPP)
+			goto out_nfserr;
+	}
 
 	if (attrmask[0] & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &args.acl);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
