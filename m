From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Metadata of renamed inode is partially persisted
 after crash
Date: Fri, 8 Mar 2019 15:36:54 +0800
Message-ID: <d8aba98a-a93d-af59-10a6-09f01b1c5ecf@huawei.com>
References: <BL0PR07MB390794909F5CCD4C4635FCB7D5730@BL0PR07MB3907.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1h2A44-0000JD-HM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Mar 2019 07:37:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h2A42-00BhtW-7G
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Mar 2019 07:37:08 +0000
In-Reply-To: <BL0PR07MB390794909F5CCD4C4635FCB7D5730@BL0PR07MB3907.namprd07.prod.outlook.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Kim, Seulbae" <seulbae@gatech.edu>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Kim, Taesoo" <taesoo@gatech.edu>, "Yoon, Jungyeon" <jungyeon@gatech.edu>, "Kashyap, Sanidhya" <sanidhya@gatech.edu>, "Xu, Meng" <meng.xu@gatech.edu>

On 2019/3/7 5:45, Kim, Seulbae wrote:
> Hi,
> =

> As we were fuzzing f2fs file system to find crash consistency bugs,
> we came across an interesting test case, which raises some questions
> regarding the consistency semantics of fdatasync().
> =

> Before proceeding to the test case,
> file "foo" already exists under the mount directory,
> and its inum is 4, size is 0, and mode is 0644.
> =

> Here's the test case:
> 0=A0 chdir(MOUNT_DIR);
> 1=A0 int fd_root =3D open(".", O_DIRECTORY, 0);
> 2 =A0truncate(=93foo=94, 100); // foo's inode number is 4
> 3 =A0sync();
> 4=A0 int fd1 =3D open("bar", O_CREAT | O_RDWR, 0400); // fd1 mapped to in=
ode #5
> (new inode)
> 5=A0 int fd2 =3D open("foo", O_RDWR, 0);=A0 =A0 =A0 =A0 =A0 =A0 =A0 // fd=
2 mapped to inode #4
> 6 =A0rename("foo", "bar"); // inode #5 is unlinked
> 7 =A0ftruncate(fd2, 500);=A0 // inode #4=92s metadata (size) is changed
> 8 =A0fdatasync(fd1);=A0 =A0 =A0 =A0// persist metadata of unlinked inode =
#5 (no
> effect on #4)
> 9 =A0chmod("bar", 0777);=A0 =A0// inode #4=92s metadata (mode) is changed
> --- CRASH ---

I wrote a test program using above executing order, do the test with some
tracepoints opened, and found that line 8 will trigger checkpoint due to
fsynced file's nlink is zero, so that all metadata operations before line 8
will be persisted. Which means line 8 persist inode #5, but actually,
effecting on inode #4.

> =

> Through the test case, we created a new inode (inode #5) named "bar" (lin=
e 5),
> but practically unlinked it by renaming inode #4's name from "foo" to "ba=
r"
> (line 6).
> As file descriptors are mapped to inodes (not names),
> line 7 changes the size of inode #4 ("bar") to 500,
> line 8 syncs the data of inode #5, which is not existent anymore, and
> line 9 changes permission of inode #4 ("bar") to 0777.
> =

> When system crashes right after executing line 9,
> the re-mounted fs image has file "foo" (inum 4), whose size is 500, but

So after checkpoint, foo has renamed to bar, eventually, image has file
"bar" (inum 4).

> mode is 0644.
> In other words, without performing fsync() on this inode,
> one of the metadata changes (size 500->100) is persisted,=A0but the other
> (mode 0644->0777) is not.
> =

> An interesting aspect is that when we swap line 7 (ftruncate) with line 9
> (chmod),=A0
> then only the mode is persisted (size: 100, mode: 0777) this time, in the
> recovered image.
> And if we remove line 8, then both size and mode of inode #4 are not pers=
isted.
> So,=A0this led us to suspect that fdatasync'ing inode #5 is actually
> affecting the metadata status of inode #4.

As we expected.

> =

> In terms of crash consistency, this is fine since we did not fsync inode =
#4.
> However, doesn't this imply that there might exist a logic bug in the
> semantics of fdatasync,

The behavior is due to checkpoint triggered by fdatasync.

> especially when the file descriptor provided as its argument points to an
> old inode
> that is practically unlinked by being overwritten through renaming?

The fdatasync semantics is not broken as we expect, right?

Thanks,

> =

> Thank you,
> -Seulbae
