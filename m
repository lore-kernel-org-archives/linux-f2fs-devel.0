Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28912C9832A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/QyIP9RYMDcRqE5rNvRcKHnJGpVWmJXEciDeAxGJaAo=; b=DxOWaKLJNoSgl6vPLKURvcNbOZ
	MEXiGrHM4TgOITzNNhvkHt0Tr/pQ74TeMN194jpdLqMn5X003OU7RjRom4Bv7YO3EKGMj8K8eouPP
	6un7FO/CCJ5BI95uTzvn1UaPubUB3OfQLwUI96Oh+LyEoxlJxuLckdqVG3nIQZimD0Ds=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBSHO-0006WJ-0H;
	Tue, 29 Sep 2026 07:29:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xBSHN-0006WD-7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAHZSB2ddBrgCa6V2DPmMYRe8Qgi1eaVASoiFwj/jsU=; b=SHAj+iAKvoDXSZPYd16KXdrhnW
 f+oh7dD02HNfimx1GgqK6Z/T9a5Cb0Iv1gA4CPH+EF2yAQo0f8YSy8OeUJPmKWxozpUjPvt9Z5g6F
 e+MsvKGxudkkA2dEX2yLc1HsfSl5wMgWvvR/f7mUa9amua3WlTfhCHVV0v6Z4LImn6tQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DAHZSB2ddBrgCa6V2DPmMYRe8Qgi1eaVASoiFwj/jsU=; b=L
 +JrIvAjJbbf+6KAd30B+VGoLhAsoLf+B5VQqxPWiLKxDpnZ7SR2LLlfc+5JP0hPlpeaq9OHV5F7gr
 ceZZu+issMGCMnHLnnFVaiEUPeBC97IjEKTguWFx3acD4jv4ehlgC8u+iFX3d2v6srk208lmd0NJL
 GSB3Un5ho7tw60zU=;
Received: from mail-pj2-f42.google.com ([74.125.227.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBSHM-0000E7-JJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 07:29:33 +0000
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so1980264a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666967; x=1791271767; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DAHZSB2ddBrgCa6V2DPmMYRe8Qgi1eaVASoiFwj/jsU=;
 b=MKbqNuxjwzzqfVssVBMZdBJw6quM69PTQ9gyQmXzx6rou5r4YRdeE8TUn48oJ3ieYK
 00iyhR5Xw1dueYJYx6PrmCdU9iAjLaBhBfJU/heZSR8r3nXnX3FjZx+XKAxRNINsRpKc
 wuxAAFkUdL8gV8Ic67wNeP/EkLE/JGMUlqsPoSGfi6n4twSLCyFS0Oqai5r4BRt0fqHN
 i5gcXaM/3RGcuribCXWZCR495TVoqskak36/2hTZMTdYhAmnI1RNiJw45nZPqVp7SG3S
 9uUHxaZNdxBVfPAl3H62Ud5de+j7D8D+/0dVbPXINjkZkgUGJ+tAt59vSvk9CPQwEOBE
 Ut4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666967; x=1791271767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DAHZSB2ddBrgCa6V2DPmMYRe8Qgi1eaVASoiFwj/jsU=;
 b=PJ3kAcmPOLfxBWS+xvITevxj6qjU8Z0K2zAMxZ1acvZw+v7CiRB8PO0oGzTgFf8DQq
 dSrjrK7k3hyrv6S7pBVwXmaMcZMXs9OhaFYuRoWI+5WLn+tF3iZ3naK6hzB+7bUQ4oXo
 2L/gBMx5MG38MdMoLS+ZE1xWxnrcMHb+uj2O6QZ5k37PwNamXqrdimKvxTL3Ii2jgMqV
 3JrxNQ1lAT7DZbz9En4CbfiX09dI+AC2W2FatIFy18mfRtnJH2VYwf+bkUs1jazkYprs
 OFkxe5AWiU2GG5XcnPS7AVsAjgFa2ltuXIX3r6i8TkvG9gikcgWEtxJuX8tBVtxj3KWL
 ZivA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRV132UGRit0BrHxImvUswRCxiT++mirc2Rs6+tTo0pSEPJ1wDktQrzPPvaC5nOTnVhADHOETVM6936s1JGYxN@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLBuscuagoRRw4nTS4nIxCTrfcJkt90h5Wvg+N0Vy2oM+uKDoSJ
 lHMkR7WO4TEHazbu+omKxxbMyMKD3ZwOm7P6bAOehOaXKkU5Omnxj+Cu
X-Gm-Gg: AYBFou040n6NdfjdSaDVPD9cNZPk0BMrk1uy7uaUIBnlmr22EmtxZR8eh+NViD0Fd9E
 ALFmGYuNHrqSx7jjZKXSB/cr8hE6uZ2jD+95/2tnwDnMcgB8wJaX4mylRtmGRIDoO+nhdhzWdPk
 rSeeIGQk9tSsLh5An8ZAmri//swGBHtry8Ojlfhey1x4HDv/px6OeotyA8JN2dGW5Oo66hod0xk
 gFEiy2AAeanAvY+498EiJc8LC/ZLg2YljZtOER4FFDryQ2WykQUw6dqVAaGQ/5tCADGVB0cjQpo
 zKAhtXtTD+0xnYr7acL3vF8zMG5e7xjGF9Hu4aBCJcKXF6jHkJ+CawWZd84uUVIqGbrmkYrdG1h
 t3m4vHUzvZwBpPhPnobb1xIyanIgmVV6grmmMSwUneilDGSwlDDV/FlJ67njUG9IfbX+EtOM48q
 cEmTgpsyOCX2RZgaXv0nlMHa76VTXreTrfMGI1MsGsw5krhRd82PuJFmgU9d19qA1BqJC/4IFPU
 UeqpzVAvGACFKm0W0PApyPg8m0gLbmoeHY=
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id
 98e67ed59e1d1-3a0b2236bfbmr10560613a91.48.1790666966647; 
 Tue, 29 Sep 2026 00:29:26 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a49804220fsm3900170a91.12.2026.09.29.00.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:29:26 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 29 Sep 2026 15:29:13 +0800
Message-ID: <cover.1790665952.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xBSHM-0000E7-JJ
Subject: [f2fs-dev] [RFC PATCH 0/6] f2fs: retain clean node blocks in a
 compressed cache
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
Cc: Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

This RFC adds a reclaimable compressed representation for clean node-cache
entries on top of the F2FS metadata cache.

The node cache avoids repeated NAT and node-block reads, but retaining a raw
node still consumes one filesystem block.  A large raw cache therefore has a
substantial memory footprint, while reclaiming entries early causes later
accesses to issue node reads again.

This series provides a middle ground:

  - active or recently accessed nodes remain in the raw representation;
  - a background worker compresses colder clean nodes into small private-slab
    objects;
  - a compressed entry keeps its NID identity;
  - access restores the raw block before normal node validation;
  - compressed data remains a discardable optimization, and restore or
    validation failure falls back to the ordinary disk-read path; and
  - both raw and compressed entries remain reclaimable by the F2FS shrinker.

Compressed representation
=========================

When the feature is enabled, NODE_CACHE uses an extended entry to retain the
compressed payload length, private-slab allocation size, CRC of the original
node block, and compression-context ownership.

Compressed payloads use per-superblock private slabs with three object sizes:

  256 bytes
  512 bytes
  1024 bytes

A result that exceeds either the configured threshold or the 1024-byte limit
is not retained.  Raw entries stay on the existing node LRU.  Compressed
entries are placed on separate 256-, 512-, and 1024-byte queues according to
their allocation size.

Ownership and restore
=====================

The conversion path may briefly hold both the raw block and a newly allocated
compressed object.  After publication, however, the entry owns only one
representation.  Compressed bytes are never submitted directly to BIO.

Restore runs while the entry lock and lookup reference still exclude normal
concurrent byte users.  It validates:

  allocation size
  compressed payload length
  LZ4 output length
  raw-block CRC
  node footer
  inode checksum
  requested node type

A raw-buffer allocation failure leaves the compressed representation intact
so that a caller may retry.  A malformed payload or later semantic validation
failure discards the optimization and uses the normal disk-read path.  The
compressed cache therefore does not replace the on-disk source of truth.

Background worker
=================

The series reuses the existing per-superblock cache thread instead of adding
a new kernel thread.  Writeback and compression keep separate due times, but
execute serially in that shared thread.

Each worker pass is bounded by:

  maximum raw scan:        1024 entries
  maximum candidates:       256 entries
  reschedule batch:          32 entries

The series adds two sysfs controls:

  node_compress_threshold
  node_compress_interval

The threshold is the maximum retained compressed payload as a percentage of
the original block; zero disables compression.  The interval range is
100--30000 ms, with a default of 1000 ms.

Reclaim policy
==============

The series lets the node shrinker reclaim raw and compressed queues
independently, so every compressed entry created by the worker remains
reclaimable.

The shrinker uses fixed reclaim weights.  A raw entry has a larger weight
because it occupies a full block.  Compressed entries are retained
preferentially, but remain reclaimable under sustained pressure.

The same weights are used for:

  - the effective shrinker count; and
  - per-queue scan quotas.

Quota rounding credit is carried across shrinker invocations.  If a queue
reaches its population cap, unused quota is redistributed to the other
queues.

REFERENCED second chance
========================

The worker and shrinker use the same REFERENCED rule:

  test REFERENCED
  clear REFERENCED
  move the entry to the tail of its current queue
  skip it in the current pass

The worker remembers the original raw-list tail so entries moved during a
pass are not revisited in that pass.

If an entry is accessed after compression completes but before publication,
the temporary compressed object is discarded and the entry receives the same
second chance.

NVMe-backed QEMU test
====================

The test environment was:

  x86_64 KVM
  4 vCPUs
  3 GiB guest memory
  2 GiB raw F2FS image
  host backing filesystem: /dev/nvme0n1p2
  guest block device: /dev/nvme0n1
  QEMU device: nvme
  cache=none
  aio=native

Each test suite created its own empty, formatted 2 GiB seed image.  For every
guest boot, the host copied that seed into an independent sparse image, and
the guest rebuilt the same file set:

  /mnt/bench/
  |-- files/
  |   |-- d-0/f-0 ... f-63
  |   |-- d-1/f-0 ... f-63
  |   `-- d-255/f-0 ... f-63
  |-- shaped/
  |   |-- b-1-0 ... b-1-3
  |   |-- b-32-0 ... b-32-3
  |   |-- b-80-0 ... b-80-3
  |   |-- b-128-0 ... b-128-3
  |   |-- b-192-0 ... b-192-3
  |   |-- b-256-0 ... b-256-3
  |   |-- b-384-0 ... b-384-3
  |   `-- b-512-0 ... b-512-3
  `-- sentinel

The files/ tree contains 256 directories with 64 files each, for 16,384
replay files.  These files build a fixed inode, dentry, and node-page
population and are accessed later in a fixed manifest order.

The shaped/ tree contains 32 zero-filled files ranging from 1 to 512 blocks.
Their different extent and block-address densities diversify node-page
contents and compression outcomes.  They contribute to the initial cache
population and subsequent compression and reclaim, but are excluded from the
timed replay, which remains limited to the 16,384 uniform small files.  The
sentinel is used only for clean unmount, remount, and content verification
after the measured workload.

The workload compares memory use and replay latency at equal node counts, and
retained nodes, node reads, and replay latency at equal node-cache memory.

For the results below, compression-off means compression admission is disabled
at runtime, while compression-on means background conversion is enabled.
Attributed node-cache memory is the sum of cache-entry bytes, raw block
buffers or compressed private-slab slots, and known fixed context bytes.  It
is an accounting metric, not measured physical RSS, and excludes allocator
metadata.

At equal node counts, both modes retained 16,676 nodes:

  compression-off attributed memory: 69,792,344 bytes
  compression-on attributed memory:   6,008,152 bytes
  memory reduction:                      91.391%

The paired median foreground replay regression was 0.845%.

At equal node counts, the compressed representation substantially reduced
attributed memory while typical replay latency remained close.

At an approximately 3 MiB attributed node-cache budget:

  compression-off:    3,199,800 bytes, 760 nodes
  compression-on:     3,207,992 bytes, 9,208 nodes
  retained-node ratio: 12.116x

Node reads were:

  compression-off:  15,668 reads / 64,176,128 bytes
  compression-on:    7,209 reads / 29,528,064 bytes
  reduction:         53.989%

The compression-on configuration also completed 9,175 compressed restores.
For the one-pass foreground replay, those restores plus 7,209 node reads equal
the 16,384 per-file node retrievals.  These counters cover F2FS node
retrievals, not all guest filesystem I/O.

The paired median foreground replay delta was -24.984%.

At the same node-cache memory budget, the compressed representation retained
more nodes, reduced node reads, and improved replay latency in this workload.

Android phone test
==================

The mechanism was also exercised on a real Android phone with application,
memory-pressure, and cache-lifecycle workloads.

Each successful trial performed:

  reboot
  launch 18 applications for a seed pass
  pre-pressure normalization
  allocate and hold 1 GiB of memory pressure for 30 seconds
  release pressure
  launch 18 applications for measured pass 1
  launch the same 18 applications for measured pass 2
  restore the original policy
  clean up and run an offline audit

The seed pass was excluded from the reported measured launch-time results.  It
populated the post-reboot F2FS node cache with application-related node
entries so that background compression, pressure reclaim, and later restore
operated on a non-empty cache.

The application set included messaging, short-video, shopping, social-media,
browser, and video applications.  Each application record retained the
package, Activity, PID, process start time, launch timing, and F2FS node-cache
counters.

In the snapshot statistics below, attached node entries are the current raw
and compressed cache entries.  Attached raw bytes count 4 KiB raw buffers,
while compressed slot bytes count allocated private-slab bucket sizes.
Node-cache logical bytes combine entry, raw-buffer, and slot accounting; they
are not measured physical RSS.

After restoring the original sysfs policy, the final snapshots showed these
trial-level means.  Restoring the policy did not flush existing cache entries:

  compression-off:
    attached node entries:      14,509
    compressed entries:              0
    attached raw bytes:      59,430,229
    node-cache logical bytes: 60,823,125

  compression-on:
    attached node entries:      25,331
    compressed entries:         16,402
    attached raw bytes:      36,573,184
    compressed slot bytes:    8,769,877
    node-cache logical bytes: 47,774,805

At the same final snapshots, the mean compressed-entry distribution per trial,
rounded to the nearest entry, was:

  256-byte:     373 entries ( 2.27%)
  512-byte:  15,116 entries (92.16%)
  1024-byte:    913 entries ( 5.57%)

Under the F2FS node-cache accounting model, compression-on changed the above
values by:

  retained node entries: +74.59%
  raw bytes:             -38.46%
  logical cache bytes:   -21.45%

The node-read count is the filesystem-wide F2FS FS_NODE_READ_IO count for the
/data mount.  Each event represents a submitted 4 KiB node-block read.  It
includes activity from the measured applications and concurrent Android
services, and is neither a per-application attribution nor a count of all
storage I/O.  The counts were:

  compression-off mean: 309,360
  compression-on mean:  287,417
  difference:             -7.09%

The compression-on trials also exercised raw-to-compressed conversion,
compressed restore, compressed-queue reclaim, and REFERENCED clear-and-move.
Each compression-on trial completed about 70,441--76,786 conversions and
retained a mean of 16,402 compressed entries in the final snapshots after
policy restoration.

In this Android workload, the compressed representation reduced node-cache
accounting memory, retained more node entries, and showed a lower filesystem-
wide node-read counter.  Raw and compressed entries continued to be reclaimed
under pressure, followed by restore and recompression during application
replay.  The observed node-read reduction describes the direction in this
workload rather than a strict per-application causal measurement.

Patch layout
============

Patch 1 generalizes metadata-cache shrinking to accept explicit lists while
preserving the behavior of existing caches.

Patch 2 adds the extended node entry, private slabs, compressed queues,
ownership, and memory accounting.

Patch 3 connects queue-aware reclaim, fixed reclaim weights, and carried
rounding credit.

Patch 4 adds restore, length and CRC validation, complete node validation,
and disk fallback.

Patch 5 adds the bounded background worker to the cache thread and exposes
the threshold and interval controls.

Patch 6 gives the worker and shrinker the same REFERENCED clear-and-move
behavior.

This series is based on F2FS dev-test commit:

  1b629035be4a ("f2fs: rename nr_pages_to_skip with nr_caches_to_skip")

I would especially appreciate feedback on:

  1. whether per-superblock 256-, 512-, and 1024-byte private slabs are an
     appropriate allocator boundary;
  2. whether fixed reclaim weights for raw blocks and compressed slots are a
     reasonable initial reclaim policy; and
  3. whether the threshold and interval provide a sufficient initial control
     interface.

Thanks,
Wenjie

Wenjie Qi (6):
  f2fs: generalize metadata cache shrinking to explicit lists
  f2fs: add compressed clean node cache representation
  f2fs: bias node cache reclaim toward raw entries
  f2fs: restore compressed node cache entries before access
  f2fs: compress clean node cache entries in background
  f2fs: give referenced node cache entries a shared second chance

 Documentation/ABI/testing/sysfs-fs-f2fs |  22 +
 fs/f2fs/Kconfig                         |  12 +
 fs/f2fs/Makefile                        |   2 +
 fs/f2fs/cache.c                         | 145 +++-
 fs/f2fs/cache.h                         |  52 +-
 fs/f2fs/data.c                          |   5 +-
 fs/f2fs/debug.c                         |  47 +-
 fs/f2fs/f2fs.h                          |  17 +
 fs/f2fs/inode.c                         |  20 +-
 fs/f2fs/node.c                          |  55 +-
 fs/f2fs/node_cache_compress.c           | 915 ++++++++++++++++++++++++
 fs/f2fs/node_cache_compress.h           | 144 ++++
 fs/f2fs/node_cache_policy.c             | 211 ++++++
 fs/f2fs/node_cache_policy.h             |  54 ++
 fs/f2fs/shrinker.c                      |   3 +-
 fs/f2fs/super.c                         |   4 +
 fs/f2fs/sysfs.c                         |  59 ++
 17 files changed, 1713 insertions(+), 54 deletions(-)
 create mode 100644 fs/f2fs/node_cache_compress.c
 create mode 100644 fs/f2fs/node_cache_compress.h
 create mode 100644 fs/f2fs/node_cache_policy.c
 create mode 100644 fs/f2fs/node_cache_policy.h


base-commit: 1b629035be4a085f59d47edc62f4e695c763a94d
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
