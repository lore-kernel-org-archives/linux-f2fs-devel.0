From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs for SMR drives
Date: Mon, 10 Aug 2015 15:05:54 +0200
Message-ID: <20150810130554.GA2347@schmorp.de>
References: <20150808135117.GA4594@schmorp.de>
	<003d01d0d356$4d5b9480$e812bd80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZOmmE-0002En-L9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 13:06:06 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZOmm9-0005U9-Uq
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 10 Aug 2015 13:06:06 +0000
Content-Disposition: inline
In-Reply-To: <003d01d0d356$4d5b9480$e812bd80$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Mon, Aug 10, 2015 at 06:20:40PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> '-s7' means that we configure seg_per_sec into 7, so our section size will

Ah, I see, I am a victim of a documentation bug then: According to the
mkfs.f2fs (1.4.0) documentation, -s7 means 256MB (2 * 2**7), so that
explains it.

Good news, I will reset ASAP!

> which may cause low performance, is that right?

Yes, if the documentation is wrong, that would explain the bad performance
of defragmented sections.

> I have no SMR device, so I have to use hard disk for testing, I can't reproduce
> this issue with cp in such device. But for rsync, one thing I note is that:
> 
> I use rsync to copy 32g local file to f2fs partition, the partition is with
> 100% utilized space and with no available block for further allocation. It
> took very long time for 'the copy', finally it reported us there is no space.

Strange. For me, in 3.18.14, I could cp and rsync to a 100% utilized
disk at full (read) speed, but it didn't do any I/O (and the files never
arrived).

That was the same partition that later had the link count mismatches.

> b) In f2fs, we use inode/data block space mixedly, so when data block number
> is zero, we can't create any file in f2fs. It makes rsync failing in step 2,
> and leads it runs into discard_receive_data function which will still
> receiving the whole src file. This makes rsync process keeping writing but
> generating no IO in f2fs filesystem.

I am sorry, that cannot be true - if file creation would fail, then rsync
simply would be unable to write anything, it wouldn't have a valid fd to
write. I also strace'd it, and it successfully open()ed and "write()ed"
AND close()ed the file.

It can only be explained by f2fs neither creating nor writing the file,
without giving an error.

In any case, instead of discarding data, the filesystem should of course
return ENOSPC, as anything else causes data loss.

> Can you please help to check that in your environment the reason of rsync
> without returning ENOSPC is the same as above?

I can already rule it out baseed on API grounds: if file creation fails
(e.g. with ENOSPC), then rsync couldn't have an fd to write data to it.
something else must go on.

The only way for this behaviour to happen is if file creation succeeds
(and wriitng and closing, too - silent data loss).

> If it is not, can you share more details about test steps, io info, and f2fs
> status info in debugfs (/sys/kernel/debug/f2fs/status).

I mounted the partition with -onoatime and no other flags, used cp -Rp to
copy a large tree until the disk utilization was 100% for maybe 20 seconds
according to /sys/kernel/debug/f2fs/status. A bit puzzled, I ^C's cp,
and tried "rsync -avP --append", which took a bit to scan the directory
information, then proceeded to write.

I also don't think rsync --append goes via the temporary file route, but in
any case, I also used rsync -avP, which does.

After writing a few dozen gigabytes (as measured by read data throughput),
I stopped both.

I don't know what you mean with "io info".

Since fsck.f2fs completely destroyed the filesystem, I cannot provide any
more f2fs debug info about it.

> IMO, real-timely increasing ratio of below stat value may be helpful to
> investigate the degression issue. Can you share us them?

I lost this filesystem to corruption as well. I will certainly retry this
test though, and will record these values.

Anyways, thanks a lot for your input so far!

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
