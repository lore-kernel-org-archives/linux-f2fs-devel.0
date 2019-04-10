From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 0/2] fscrypt: improve encrypted symlink performance
Date: Wed, 10 Apr 2019 13:21:13 -0700
Message-ID: <20190410202115.64501-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This series improves the performance of following encrypted symlinks on
ext4, f2fs, and ubifs.

Eric Biggers (2):
  vfs: use READ_ONCE() to access ->i_link
  fscrypt: cache decrypted symlink target in ->i_link

 fs/crypto/hooks.c       | 40 +++++++++++++++++++++++++++++++++-------
 fs/crypto/keyinfo.c     | 21 +++++++++++++++++++++
 fs/ext4/super.c         |  3 +++
 fs/f2fs/super.c         |  3 +++
 fs/namei.c              |  4 ++--
 fs/ubifs/super.c        |  3 +++
 include/linux/fscrypt.h |  5 +++++
 7 files changed, 70 insertions(+), 9 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
